Received: from mail-ua0-f175.google.com ([209.85.217.175]:33059 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdEKL2T (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 May 2017 07:28:19 -0400
Received: by mail-ua0-f175.google.com with SMTP id e28so26224035uah.0
        for <fstests@vger.kernel.org>; Thu, 11 May 2017 04:28:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170511055842.GF7250@eguan.usersys.redhat.com>
References: <1494416764-22528-1-git-send-email-agruenba@redhat.com> <20170511055842.GF7250@eguan.usersys.redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 11 May 2017 13:28:17 +0200
Message-ID: <CAHc6FU4d9akCB2hk_NrrrKZuxbO13NK+5P3=ydjxDbwQqzWJJA@mail.gmail.com>
Subject: Re: [PATCH] src/seek_sanity_test: Fix for filesystems without delayed allocation
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Eryu,

thanks for the review.

On Thu, May 11, 2017 at 7:58 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Wed, May 10, 2017 at 01:46:04PM +0200, Andreas Gruenbacher wrote:
>> src/seek_sanity_test (test generic/285) assumes that after fallocating
>> space in a file, fseek SEEK_HOLE / SEEK_DATA will still report the
>> allocated space as a hole.  This isn't true on filesystems that don't
>> support delayed allocation, so skip the affected tests in that case.
>>
>> Tested on xfs and gfs2 + patches for fseek SEEK_HOLE / SEEK_DATA.
>
> I'm not sure if this is really about delayed allocation, I tried
> nodelalloc mounted ext4, test still passed. And the following test
> reported fallocated space as HOLE, on both delalloc and nodelalloc
> mounted ext4:
>
> [root@bootp-73-5-205 xfstests]# grep vda6 /proc/mounts
> /dev/vda6 /mnt/ext4 ext4 rw,seclabel,relatime,nodelalloc,data=ordered 0 0
> [root@bootp-73-5-205 xfstests]# rm /mnt/ext4/testfile
> [root@bootp-73-5-205 xfstests]# xfs_io -fc "falloc 0 1m" -c "seek -h 0" -c "seek -d 0" /mnt/ext4/testfile
> Whence  Result
> HOLE    0
> Whence  Result
> DATA    EOF
> [root@bootp-73-5-205 xfstests]# mount -o remount,delalloc /mnt/ext4
> [root@bootp-73-5-205 xfstests]# grep vda6 /proc/mounts
> /dev/vda6 /mnt/ext4 ext4 rw,seclabel,relatime,data=ordered 0 0
> [root@bootp-73-5-205 xfstests]# rm /mnt/ext4/testfile
> [root@bootp-73-5-205 xfstests]# xfs_io -fc "falloc 0 1m" -c "seek -h 0" -c "seek -d 0" /mnt/ext4/testfile
> Whence  Result
> HOLE    0
> Whence  Result
> DATA    EOF
>
> I noticed that test07/8/9 are the only three that test unwritten
> extents, perhaps not supporting unwritten extents are the reason?

You are right, unwritten extents is the correct term for that
particular technique. I noticed that some additional error checking
makes sense as well, so I'll repost.

Thanks,
Andreas
