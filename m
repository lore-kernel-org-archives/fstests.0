Received: from mx1.redhat.com ([209.132.183.28]:38967 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756713AbbJVOgJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 22 Oct 2015 10:36:09 -0400
Subject: Re: [PATCH 2/2] dm-thinp demo test
References: <5627FA00.70003@redhat.com> <5627FBE8.3030408@sandeen.net>
 <20151022094722.GL3558@dhcp-13-216.nay.redhat.com>
 <5628EF2A.3020604@sandeen.net>
From: Eric Sandeen <sandeen@redhat.com>
Message-ID: <5628F457.7020605@redhat.com>
Date: Thu, 22 Oct 2015 09:36:07 -0500
MIME-Version: 1.0
In-Reply-To: <5628EF2A.3020604@sandeen.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>, Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>
List-ID: <fstests@vger.kernel.org>

On 10/22/15 9:14 AM, Eric Sandeen wrote:
>>> +_workout
>>> >> +_dmthin_check_fs
>> > 
>> > btrfs fails the fs check, because btrfs changes lv device name in df
>> > output, from /dev/mapper/xxx to /dev/dm-x, so _check_scratch_fs couldn't
>> > umount it and btrfsck runs on mounted btrfs.
> Huh, weird.  I'll admit that I did not test btrfs.  Other filesystems
> worked for you?  I'm not sure how btrfs can change df output...
> 
> mapper symlinks have been a constant source of pain for fstests.  :(
> 
>> > Adding "$UMOUNT_PROG $SCRATCH_MNT" before _dmthin_check_fs is a
>> > workaround, though I think it's a btrfs issue.
> Hm, ok, thanks; easy enough to do that I guess.

ALthough, it seems to be working for me here; I do fail because btrfs
emits a warning in dmesg:

[215098.204612] BTRFS warning (device dm-6): Skipping commit of aborted transaction.
[215098.212074] ------------[ cut here ]------------
[215098.216794] WARNING: CPU: 3 PID: 19408 at fs/btrfs/transaction.c:1708 cleanup_transaction+0x86/0x2c0 [btrfs]()

which leads to:

_check_dmesg: something found in dmesg (see /mnt/test2/git/xfstests/results//generic/115.dmesg)
Ran: generic/115
Failures: generic/115

It's "just" a warning, though, so I'm not really sure this should be failing the test.

-Eric
