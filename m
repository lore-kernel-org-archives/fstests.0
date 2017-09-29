Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:57716 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751855AbdI2JWp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Sep 2017 05:22:45 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1dxrVJ-0005I3-FW
        for fstests@vger.kernel.org; Fri, 29 Sep 2017 19:22:41 +1000
Date: Fri, 29 Sep 2017 19:22:41 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: copy_file_range test failures, maybe iscsi related?
Message-ID: <20170929092241.GD15067@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

I've just got my iscsi test systems back up and running and I'm
seeing tests generic/43[014] all getting stuck in the same way.
xfs_io is hard looping and not making progress, and the strace
output looks like this:

.....
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
copy_file_range(4, [1000], 3, [0], 100, 0) = 0
.....

I can kill the xfs_io process and the test then fails and moves on
to the next, so it appears there's a problem with the
copy_file_range() implementation. On the same kernel (4.14-rc2) but
different devices (local SSD, ram disk or pmem) there is no problems
being reported by these tests and they complete extremely quickly.

It's clearly not related to XFS's reflink mkfs option, because I can
reproduce it on filesystems without that option enabled.  And I just
reproduced it on an ext4 filesystem, too, so this implies it is
probably an iscsi copy offload bug.

Is anyone else running xfstests on iscsi devices, and if so, are
they seeing these problems?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
