Received: from mail.sigma-star.at ([95.130.255.111]:45996 "EHLO
        mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbdEQJ4Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 05:56:16 -0400
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Add UBIFS support to xfstests
Date: Wed, 17 May 2017 11:55:28 +0200
Message-Id: <20170517095531.11818-1-david.oberhollenzer@sigma-star.at>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, richard@nod.at
List-ID: <fstests@vger.kernel.org>

Hello,


This patch series attempts to add support for UBIFS to xfstests, based
on the previous patches for xfstests-dev and xfstests-bld.


The first patch adds UBIFS support to xfstests-dev. It mainly deals with
a few quirks of UBIFS, e.g. requiring a char device rather than a block
device.

The second patch modifies an encryption test to also accept the slightly
different behaviour of UBIFS.


The final patch updates xfstests-bld (a separate project maintained by
Theodore Ts'o) to support UBIFS with kvm-xfstests and gce-xfstests. It
uses block2mtd to emulate MTD devices using standard block devices, then
layers UBI volumes on top of these.

It is basically Eric's original xfstests-bld patch but adds one line to
xfstests-packages to require the mtd-utils package to be added to the
file system image.


Modifying the xfstests-bld patch to use nandsim (which simulates a NAND
flash MTD device) instead of block2mtd has been considered, however the
default size of 128MiB is slightly too small for generic/129.

Nandsim does not have an option to directly specify the size of the
backing buffer but instead requires a set of NAND ID bytes that imply
(among other things) the size of the chip (example, see 1). The ID bytes
would have to be added to the kernel arguments for the UBIFS case. It
might be desirable to document this somehow, for the next person who
has to adjust the size, once a new test exhausts it. Also, it would be
ultimately limted by available RAM and what can be encoded using the
NAND ID bytes.

So right now, it looks like block2mtd is the simplest option for getting
xfstests-bld to work with UBIFS.


The first two patches have been tested inside a Debian Jessie VM, using
the UBIFS kernel tree from git://git.infradead.org/linux-ubifs.git and
nandsim for emulating a nand flash device.

The patch for xfstests-bld was tested in combination with the xfstests
patches on a clean Ubuntu 16.04 installation.


David

[1] http://www.linux-mtd.infradead.org/nand-data/nanddata.html
