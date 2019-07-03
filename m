Received: from mail.cn.fujitsu.com ([183.91.158.132]:34904 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727296AbfGCIPI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Jul 2019 04:15:08 -0400
Message-ID: <5D1C6406.1040304@cn.fujitsu.com>
Date: Wed, 3 Jul 2019 16:15:02 +0800
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/042: add sleep before shutdown
References: <1562117471-2376-1-git-send-email-xuyang2018.jy@cn.fujitsu.com> <20190703033429.GA19593@mit.edu>
In-Reply-To: <20190703033429.GA19593@mit.edu>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

on 2019/07/03 11:34, Theodore Ts'o wrote:

> On Wed, Jul 03, 2019 at 09:31:11AM +0800, Yang Xu wrote:
>> On some server machines, the memory was so big that we
>> don't have enough time to submit file.  After umoumt,
>> hexdump will report no such file or directory on ext4.
> Um, so this is passing for me using ext4.  The file system is getting
> shutdown via "./src/godown -f $mnt".  The -f causes the shutdown file
> system to be called with the LOGFLUSH flag set.  This causes a forced
> journal commit before the file system is shut down, so how much memory
> the system might have should be irrelvant.
>
> The only thing I can think of is if the journal was not enabled, but
> generic/042 calls _require_metadata_journalling, and so the test will
> be skipped if the file system was created without a journal or if the
> noload mount option is passed as part of the test config.
Hi Theodore

Thanks for your quick reply.
I am trying it about how much memory leads to case fails(I decrease memory to 8G,swap 2G, processor 2,
and off numa in grub2, this cases also fails.). It look likes not memeory affect this.

As you said, generic/042 has enabled journal.  But filesystem errors occur(please see the
last dmesg).  I doubt whether the file metadata journal trancation has been aborted or
clear, and data has been written into disk. So the error occur?

my local.config as below(sda6 sda7 size is 20G):
TEST_DIR=/mnt/xfstests/test
TEST_DEV=/dev/sda6
SCRATCH_MNT=/mnt/xfstests/scratch
SCRATCH_DEV=/dev/sda7
export XFS_MKFS_OPTIONS="-m reflink=1"

> Can you say a little bit more about your test configuration and test
> environment?  This test really shouldn't be needing your patch;
> sleeping for ten seconds should *not* be making a difference as to
> whether or not the file exists for hexdump to test.  And to the extent
> that the test is trying to find race conditions, adding a sleep 10
> defeats the purpose of the test.
Ok. I see. Add ten sleep will defeat the purpose the test like fsync.
my test environment as below(hardware supports numa):
package:e2fsprogs-1.44.6-3.el8.x86_6
kernel:4.18.0-100.el8.x86_64
Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
memory:128G, swap:9G, processors:112
Disk identifier: ADA6C75F-FB05-412B-981B-510BEB2346B3

dmesg(From dmesg,  filesystem error occurs):

[165576.774479] run fstests generic/042 at 2019-07-04 11:39:47
[165577.900431] EXT4-fs (sda7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[165577.901681] EXT4-fs (sda7): shut down requested (1)
[165577.902069] Aborting journal on device sda7-8.
[165578.995533] EXT4-fs (sda7): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[165579.263674] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
[165579.267658] EXT4-fs (loop0): shut down requested (1)
[165579.268159] Aborting journal on device loop0-8.
[165579.297715] JBD2: Detected IO errors while flushing file data on loop0-8
[165579.360537] EXT4-fs warning (device loop0): ext4_clear_journal_err:4992: Filesystem error recorded from previous mount: IO failure
[165579.360540] EXT4-fs warning (device loop0): ext4_clear_journal_err:4993: Marking fs in need of filesystem check.
[165579.395128] EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
[165579.412176] EXT4-fs (loop0): recovery complete
[165579.429230] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
[165579.777900] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
[165579.781827] EXT4-fs (loop0): shut down requested (1)
[165579.782353] Aborting journal on device loop0-8.
[165579.817722] JBD2: Detected IO errors while flushing file data on loop0-8
[165579.897782] EXT4-fs warning (device loop0): ext4_clear_journal_err:4992: Filesystem error recorded from previous mount: IO failure
[165579.897785] EXT4-fs warning (device loop0): ext4_clear_journal_err:4993: Marking fs in need of filesystem check.
[165579.926637] EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
[165579.943837] EXT4-fs (loop0): recovery complete
[165579.960779] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
[165580.309274] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
[165580.313196] EXT4-fs (loop0): shut down requested (1)
[165580.313733] Aborting journal on device loop0-8.
[165580.326363] JBD2: Detected IO errors while flushing file data on loop0-8
[165580.412144] EXT4-fs warning (device loop0): ext4_clear_journal_err:4992: Filesystem error recorded from previous mount: IO failure
[165580.412145] EXT4-fs warning (device loop0): ext4_clear_journal_err:4993: Marking fs in need of filesystem check.
[165580.446685] EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
[165580.463867] EXT4-fs (loop0): recovery complete
[165580.480805] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
[165580.723550] EXT4-fs (sda7): mounted filesystem with ordered data mode. Opts: acl,user_xa

> 				- Ted
>
>
>
