import math
import torch
import torch.nn as nn
import torch.nn.functional as F


class BasicBlock(nn.Module):
    def __init__(self, in_planes, out_planes, stride, dropRate=0.0):
        super(BasicBlock, self).__init__()
        self.bn1 = nn.BatchNorm2d(in_planes)
        self.relu1 = nn.ReLU(inplace=True)
        self.conv1 = nn.Conv2d(in_planes, out_planes, kernel_size=3, stride=stride,
                               padding=1, bias=False)
        self.bn2 = nn.BatchNorm2d(out_planes)
        self.relu2 = nn.ReLU(inplace=True)
        self.conv2 = nn.Conv2d(out_planes, out_planes, kernel_size=3, stride=1,
                               padding=1, bias=False)
        self.droprate = dropRate
        self.equalInOut = (in_planes == out_planes)
        self.convShortcut = (not self.equalInOut) and nn.Conv2d(
            in_planes, out_planes, kernel_size=1, stride=stride, padding=0,
            bias=False) or None

    def forward(self, x):
        if not self.equalInOut:
            x = self.relu1(self.bn1(x))
        else:
            out = self.relu1(self.bn1(x))
        out = self.relu2(self.bn2(self.conv1(out if self.equalInOut else x)))
        if self.droprate > 0:
            out = F.dropout(out, p=self.droprate, training=self.training)
        out = self.conv2(out)
        return torch.add(x if self.equalInOut else self.convShortcut(x), out)


class NetworkBlock(nn.Module):
    def __init__(self, nb_layers, in_planes, out_planes, block, stride, dropRate=0.0):
        super(NetworkBlock, self).__init__()
        self.layer = self._make_layer(
            block, in_planes, out_planes, nb_layers, stride, dropRate)

    def _make_layer(self, block, in_planes, out_planes, nb_layers, stride, dropRate):
        layers = []
        for i in range(int(nb_layers)):
            layers.append(block(i == 0 and in_planes or out_planes,
                                out_planes, i == 0 and stride or 1, dropRate))
        return nn.Sequential(*layers)

    def forward(self, x):
        return self.layer(x)


class WideResNet(nn.Module):
    def __init__(self, depth, num_classes, widen_factor=1, dropRate=0.0):
        super(WideResNet, self).__init__()
        n_channels = [16, 16 * widen_factor,
                      32 * widen_factor, 64 * widen_factor]
        assert((depth - 4) % 6 == 0)
        n = (depth - 4) / 6
        block = BasicBlock
        # 1st conv before any network block
        self.conv1 = nn.Conv2d(3, n_channels[0], kernel_size=3, stride=1,
                               padding=1, bias=False)
        # 1st block
        self.layer1 = NetworkBlock(
            n, n_channels[0], n_channels[1], block, 1, dropRate)
        # 2nd block
        self.layer2 = NetworkBlock(
            n, n_channels[1], n_channels[2], block, 2, dropRate)
        # 3rd block
        self.layer3 = NetworkBlock(
            n, n_channels[2], n_channels[3], block, 2, dropRate)
        # global average pooling and classifier
        self.bn1 = nn.BatchNorm2d(n_channels[3])
        self.relu = nn.ReLU(inplace=True)
        self.linear = nn.Linear(n_channels[3], num_classes)
        self.n_channels = n_channels

        for m in self.modules():
            if isinstance(m, nn.Conv2d):
                n = m.kernel_size[0] * m.kernel_size[1] * m.out_channels
                m.weight.data.normal_(0, math.sqrt(2. / n))
            elif isinstance(m, nn.BatchNorm2d):
                m.weight.data.fill_(1)
                m.bias.data.zero_()
            elif isinstance(m, nn.Linear):
                m.bias.data.zero_()

    def forward(self, x):
        out = self.conv1(x)
        out = self.layer1(out)
        out = self.layer2(out)
        out = self.layer3(out)
        out = self.relu(self.bn1(out))
        out = F.avg_pool2d(out, 8)
        out = out.view(-1, self.n_channels[-1])
        return self.linear(out)

    def get_channel_num(self):
        return self.n_channels


def WRN10_4(num_classes=10):
    return WideResNet(depth=10, num_classes=num_classes, widen_factor=4)


def WRN16_1(num_classes=10):
    return WideResNet(depth=16, num_classes=num_classes, widen_factor=1)


def WRN16_2(num_classes=10):
    return WideResNet(depth=16, num_classes=num_classes, widen_factor=2)


def WRN16_4(num_classes=10):
    return WideResNet(depth=16, num_classes=num_classes, widen_factor=4)


def WRN16_8(num_classes=10):
    return WideResNet(depth=16, num_classes=num_classes, widen_factor=8)


def WRN28_2(num_classes=10):
    return WideResNet(depth=28, num_classes=num_classes, widen_factor=2)


def WRN22_4(num_classes=10):
    return WideResNet(depth=22, num_classes=num_classes, widen_factor=4)


def WRN22_8(num_classes=10):
    return WideResNet(depth=22, num_classes=num_classes, widen_factor=8)


def WRN28_1(num_classes=10):
    return WideResNet(depth=28, num_classes=num_classes, widen_factor=1)


def WRN10_1(num_classes=10):
    return WideResNet(depth=10, num_classes=num_classes, widen_factor=1)


def WRN40_1(num_classes=10):
    return WideResNet(depth=40, num_classes=num_classes, widen_factor=1)


def WRN40_4(num_classes=10):
    return WideResNet(depth=40, num_classes=num_classes, widen_factor=4)
