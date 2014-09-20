Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:59665 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756709AbaITARX (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 19 Sep 2014 20:17:23 -0400
Message-ID: <541CC790.7060306@sandeen.net>
Date: Fri, 19 Sep 2014 19:17:20 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] generic: add mmap write vs truncate/remap test
References: <1410918113-23516-1-git-send-email-david@fromorbit.com> <1410918113-23516-5-git-send-email-david@fromorbit.com>
In-Reply-To: <1410918113-23516-5-git-send-email-david@fromorbit.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 9/16/14 8:41 PM, Dave Chinner wrote:
> This test exposed a problem with mapped writes to the tail page of a
> file in XFS and potentially ext4. Eric did all the hard work of
> taking the bug report and generating the reproducable test case
> on ext4, but I haven't been able to reproduce then problem on ext4.
> 
> Regardless, make it a generic test so that we can ensure that all
> filesystems handle the case correctly.

Oof, kermit on #xfs points out that even this is sufficient to show
a problem:

 mkfs.ext4 -b 1024 -F empty.img
  mount -o loop empty.img mnt
  sync

xfs_io -f -t \
-c            "pwrite               0          0x210  "      \
-c            "mmap      -rw        0          0xd08  "      \
-c            "mwrite    -S         0x50       0x210  0xaf8"  \
-c            "truncate                        0x1000"  \
mnt/testfile

  echo "==== Pre-Remount ==="
  hexdump -C mnt/testfile | tail -n 8
  umount mnt/
  mount -o loop empty.img mnt
  echo "==== Post-Remount =="
  hexdump -C mnt/testfile | tail -n 8



i'm not sure about the testcase - mmapping beyond EOF? - but seeing data
change after remount looks scary regardless.

==== Pre-Remount ===
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000210  50 50 50 50 50 50 50 50  50 50 50 50 50 50 50 50  |PPPPPPPPPPPPPPPP|
*
00000d00  50 50 50 50 50 50 50 50  00 00 00 00 00 00 00 00  |PPPPPPPP........|
00000d10  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00001000
==== Post-Remount ==
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000210  50 50 50 50 50 50 50 50  50 50 50 50 50 50 50 50  |PPPPPPPPPPPPPPPP|
*
00000400  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00001000

-Eric

