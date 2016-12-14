Received: from bombadil.infradead.org ([198.137.202.9]:60354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755857AbcLNQnP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Dec 2016 11:43:15 -0500
Date: Wed, 14 Dec 2016 08:43:14 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: trouble with generic/081
Message-ID: <20161214164314.GA25105@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu,

I'm running into a fairly reproducable issue with generic/081
(about every other run): For some reason the umount call in
_cleanup doesn't do anything because it thinks the file system isn't
mounted, but then vgremove complains that there is a mounted file
system.  This leads to the scratch device no being release and all
subsequent tests failing.

Here is the output if I let the commands in _cleanup print to stdout:

QA output created by 081
Silence is golden
umount: /mnt/test/mnt_081: not mounted
  Logical volume vg_081/snap_081 contains a filesystem in use.
  PV /dev/sdc belongs to Volume Group vg_081 so please use vgreduce first.

You added a comment in _cleanup that sais:

# lvm may have umounted it on I/O error, but in case it does not

Does LVM really unmount filesystems on it's own?  Could we be racing
with it?

With a "sleep 1" added before the umount call the test passes reliably
for me, but that seems like papering over the issue.
