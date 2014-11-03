Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:42189 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbaKCI3m convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 3 Nov 2014 03:29:42 -0500
Received: by mail-lb0-f180.google.com with SMTP id u10so444359lbd.25
        for <fstests@vger.kernel.org>; Mon, 03 Nov 2014 00:29:41 -0800 (PST)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <707521534.1995887.1415000464631.JavaMail.zimbra@redhat.com>
References: <195605038.1993779.1414999815830.JavaMail.zimbra@redhat.com>
	<707521534.1995887.1415000464631.JavaMail.zimbra@redhat.com>
Date: Mon, 3 Nov 2014 08:29:41 +0000
Message-ID: <CAL3q7H5Zfyvc-Ovq6ssMWrd_mdp_QTX9xs718Miqi6MK7Jybvw@mail.gmail.com>
Subject: Re: btrfs/010: what's the purpose of test case
From: Filipe David Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: Xu Wang <xuw@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 3, 2014 at 7:41 AM, Xu Wang <xuw@redhat.com> wrote:
> Hi,
>
>   I run the btrfs/010 for kernel 3.10, the result is failed. When I read the case, I think it may be wrong.
>   So I post this letter, and wanna to verify it.
>
>   The case(btrfs/010) firstly produced a file with some extents in a sub volume, then created 2 snaps of the
>   sub volume. Then defrag the file in sub volume, and hope the extents numbers are same for sub volume, snap1
>   and snap2.
>   The btrfs's snapshot is based on cow, so defrag the original sub volume's file will not affect the file in
>   snapshot? Am I right?
>   If I am right, the operation "num_extent_orig=`_extent_count $subvol/foobar`" in btrfs/010 should be before
>   the defrag operation. And I will send a patch to fix it.

The test fails because snapshot aware defrag was disabled in the
kernel sometime ago due to some issues with that feature. The change
that disabled it was backported to 3.10:

https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=a082f872743e09fe2cdf870b2d8f1b5dccd36cf7

The test is correct and works without that patch.

>
>   Best regards,
>
> --
> George Wang 王旭
>
> Kernel Quantity Engineer
> Red Hat Software (Beijing) Co.,Ltd
> IRC:xuw
> Tel:+86-010-62608041
> Phone:15901231579
> 9/F, Tower C, Raycom
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Filipe David Manana,

"Reasonable men adapt themselves to the world.
 Unreasonable men adapt the world to themselves.
 That's why all progress depends on unreasonable men."
