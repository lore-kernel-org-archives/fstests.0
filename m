Received: from sandeen.net ([63.231.237.45]:59921 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbcGGCra (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 6 Jul 2016 22:47:30 -0400
Subject: Re: [PATCH v2] xfstests, generic: add project quota attribute tests
References: <1467786171-21127-1-git-send-email-wangshilong1991@gmail.com>
 <20160706233533.GK27480@dastard>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <d0018d66-cb32-16df-b46e-5c418cc4bfae@sandeen.net>
Date: Wed, 6 Jul 2016 21:47:28 -0500
MIME-Version: 1.0
In-Reply-To: <20160706233533.GK27480@dastard>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Wang Shilong <wangshilong1991@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, sihara@ddn.com, lixi@ddn.com, Wang Shilong <wshilong@ddn.com>
List-ID: <fstests@vger.kernel.org>

On 7/6/16 6:35 PM, Dave Chinner wrote:

...

>> +_require_scratch
>> +_require_chattr
>> +_require_test_lsattr
>> +_require_quota
> 
> needs  _require_prjquota, and that function needs to be modified to
> detect for both XFS and ext4 support.

I think that if there is desire to test both xfs and non-xfs userspace
with project quota, then we need to differentiate between "e2fsprogs
and linux-quota and the kernel all support it" and "xfsprogs and
the kernel both support it" don't we?

IOWs if the test uses setquota/repquota, chattr, mkfs, and fsck to
work with project quota, then that's a different set of requirements
from a test using xfs_io, xfs_quota, etc.

-Eric
