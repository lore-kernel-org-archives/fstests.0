Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A0C433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Feb 2021 09:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0F564ECF
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Feb 2021 09:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhBXJYC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Feb 2021 04:24:02 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:44066 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbhBXJXu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Feb 2021 04:23:50 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id ED32445C263;
        Wed, 24 Feb 2021 11:22:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1614158563; bh=r6eLF49Wl0msBws4kQmfMepZ+X/8jSJe+qDtJJkIhcQ=;
        h=References:From:To:Cc:Subject:In-reply-to:Date;
        b=E8Fus55q6ZnGa+wlumgqbAek9VvOHVM9wTq+0dfwGbKrpOnYMLkL4nJQGT4TLXBtj
         OOWlc/WIsyacZ62k+TULVp5lOcpoq3F6CLiO+DhAzjqM153Zc6vX8hdaJGwzOFj2JT
         uussOTaipSh8xvhJu05FMhynsj5b+6R+KsCgKVt0=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id DD04845C260;
        Wed, 24 Feb 2021 11:22:42 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id YG_wv2FsvNXL; Wed, 24 Feb 2021 11:22:42 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 72C5B45C25F;
        Wed, 24 Feb 2021 11:22:42 +0200 (EET)
Received: from nas (unknown [45.87.95.231])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id B73871BE0092;
        Wed, 24 Feb 2021 11:22:40 +0200 (EET)
References: <20210223134042.2212341-1-cgxu519@mykernel.net>
 <4ki1rjgu.fsf@damenly.su>
 <177d33c0982.10b8858b515683.1169986601273192029@mykernel.net>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     cgxu519@mykernel.net
Cc:     guaneryu <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/473: fix expectation properly in out file
In-reply-to: <177d33c0982.10b8858b515683.1169986601273192029@mykernel.net>
Message-ID: <wnuxq0px.fsf@damenly.su>
Date:   Wed, 24 Feb 2021 17:22:35 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBlzQh1+nQ3rcDQU2qyxVPp7o+PvDsBBdmWXyNjCNe1YPUxGr7h97Nxyk
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On Wed 24 Feb 2021 at 16:51, Chengguang Xu <cgxu519@mykernel.net>=20
wrote:

>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-02-24 15:52:17 Su Yue <=
l@damenly.su> =E6=92=B0=E5=86=99=20
>  ----
>  >
>  > Cc to the author and linux-xfs, since it's xfsprogs related.
>  >
>  > On Tue 23 Feb 2021 at 21:40, Chengguang Xu=20
>  > <cgxu519@mykernel.net>
>  > wrote:
>  >
>  > > It seems the expected result of testcase of "Hole + Data"
>  > > in generic/473 is not correct, so just fix it properly.
>  > >
>  >
>  > But it's not proper...
>  >
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > > ---
>  > >  tests/generic/473.out | 2 +-
>  > >  1 file changed, 1 insertion(+), 1 deletion(-)
>  > >
>  > > diff --git a/tests/generic/473.out b/tests/generic/473.out
>  > > index 75816388..f1ee5805 100644
>  > > --- a/tests/generic/473.out
>  > > +++ b/tests/generic/473.out
>  > > @@ -6,7 +6,7 @@ Data + Hole
>  > >  1: [256..287]: hole
>  > >  Hole + Data
>  > >  0: [0..127]: hole
>  > > -1: [128..255]: data
>  > > +1: [128..135]: data
>  > >
>  > The line is produced by `$XFS_IO_PROG -c "fiemap -v 0 65k"=20
>  > $file |
>  > _filter_fiemap`.
>  > 0-64k is a hole and 64k-128k is a data extent.
>  > fiemap ioctl always returns *complete* ranges of extents.
>
> Manual testing result in latest kernel like below.
>
> [root@centos test]# uname -a
> Linux centos 5.11.0+ #5 SMP Tue Feb 23 21:02:27 CST 2021 x86_64=20
> x86_64 x86_64 GNU/Linux
>
> [root@centos test]# xfs_io -V
> xfs_io version 5.0.0
>
> [root@centos test]# stat a
>   File: a
>   Size: 4194304         Blocks: 0          IO Block: 4096=20
>   regular file
> Device: fc01h/64513d    Inode: 140         Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/=20
> root)
> Access: 2021-02-24 16:33:20.235654140 +0800
> Modify: 2021-02-24 16:33:25.070641521 +0800
> Change: 2021-02-24 16:33:25.070641521 +0800
>  Birth: -
>
> [root@centos test]# xfs_io -c "pwrite 64k 64k" a
> wrote 65536/65536 bytes at offset 65536
> 64 KiB, 16 ops; 0.0000 sec (992.063 MiB/sec and 253968.2540=20
> ops/sec)
>
> [root@VM-8-4-centos test]# xfs_io -c "fiemap -v 0 65k" a
> a:
>  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>    0: [0..127]:        hole               128
>    1: [128..135]:      360..367             8   0x1
>

Sorry, my carelessness. I only checked btrfs implementation but=20
xfs
and ext4 do return the change you made.


> [root@centos test]# xfs_io -c "fiemap -v 0 128k" a
> a:
>  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>    0: [0..127]:        hole               128
>    1: [128..255]:      360..487           128   0x1
>
>
>  >
>  > You may ask why the ending hole range is not aligned to 128=20
>  > in
>  > 473.out. Because
>  > fiemap ioctl returns nothing of querying holes. xfs_io does=20
>  > the
>  > extra
>  > print work for holes.
>  >
>  > xfsprogs-dev/io/fiemap.c:
>  > for holes:
>  >  153     if (lstart > llast) {
>  >  154         print_hole(0, 0, 0, cur_extent, lflag, true,=20
>  >  llast,
>  >  lstart);
>  >  155         cur_extent++;
>  >  156         num_printed++;
>  >  157     }
>  >
>  > for the ending hole:
>  >   381     if (cur_extent && last_logical < range_end)
>  >   382         print_hole(foff_w, boff_w, tot_w, cur_extent,=20
>  >   lflag,
>  >   !vflag,
>  >   383                BTOBBT(last_logical),=20
>  >   BTOBBT(range_end));
>  >
>  > >  Hole + Data + Hole
>  > >  0: [0..127]: hole
>  > >  1: [128..255]: data
>  >

