Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D070DC4708D
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Jan 2023 11:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjAFLLG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjAFLLF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Jan 2023 06:11:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9006E0E1
        for <fstests@vger.kernel.org>; Fri,  6 Jan 2023 03:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673003420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p7ZQiUFtWQXJDo4TLwNtSP99uTC5tMW/bkJmiSIGuRI=;
        b=QYOZ6P/qUUoZy9/F/cxn/N5xtWNMrc02KqqceXwi4vBybzz8Vkl+yLgB3e6fmPxIWQHxLo
        fv5NZQDB9nZfwJDSMYnfmT+5we8y2yjU7DHyYYXoWmYos/B36mB2Qrny/LrRTXPCUZ8C+j
        BQHyB7TZScMyolNV/xGvopIbDlf89uo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-D8xzEmMCO22-CTNl2dvtOQ-1; Fri, 06 Jan 2023 06:10:18 -0500
X-MC-Unique: D8xzEmMCO22-CTNl2dvtOQ-1
Received: by mail-lj1-f197.google.com with SMTP id f6-20020a05651c02c600b0027ffbbfa9f5so315044ljo.14
        for <fstests@vger.kernel.org>; Fri, 06 Jan 2023 03:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7ZQiUFtWQXJDo4TLwNtSP99uTC5tMW/bkJmiSIGuRI=;
        b=NqJVFE1s3yjIT2RZRdFlz/sb+JDoYlv2sA4g+GfsCtc4yMVe3GwnyO7o+Bqcc0zU6/
         9IeGeHnQFPsAMrKU2lxLXn2ypDVXlScV6W+6AX0EiS4YA0ikAUVUcw7V2kquuqxvJHuX
         awzMiUMcnmrVzAKxMCVCdt6dPP1B165xSC+GhszQNX23OJcdE0YpUI15pkeHQA26G5Pm
         QkwtB3QOAz2Ee5c23sKP/oySwNg/giH/SQmt1l1lvaIwaC4n7UGOQAR9JGMsBLyk+HW6
         f6H1c1ACyotCffTjFYXwkCn4Kil2WJwdG44uYyugNev5HU7ucphBgvdz7b+Z44CHFAbM
         rLWQ==
X-Gm-Message-State: AFqh2kpSGSGKBus7q+chsxqjaNgOt7wYSY32y+GZ0BOqnE8kEVvzS2ce
        70YUExjx83QrS7/a/gXxVuycC/cClwuEyqtN9nXeY7MpARYozbNniUeBLK4L54G0FNSCSiwk1TV
        Zo7nFGCwhlM+T83KbcaUovivqlYCSj0ugMA==
X-Received: by 2002:a05:6512:146:b0:4b5:73e3:fabf with SMTP id m6-20020a056512014600b004b573e3fabfmr5453484lfo.456.1673003416751;
        Fri, 06 Jan 2023 03:10:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtmyJJ5NCSLdPkFee0b6OUR+LhNIclzrvOQxWyZvip2qIcSir9J7bTUWvH7XWcs9BxPHHiOmTwd8LpAooVLnhw=
X-Received: by 2002:a05:6512:146:b0:4b5:73e3:fabf with SMTP id
 m6-20020a056512014600b004b573e3fabfmr5453481lfo.456.1673003416478; Fri, 06
 Jan 2023 03:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20230104042801.217898-1-bxue@redhat.com> <Y7fU4pRA+LHhsMKj@sol.localdomain>
In-Reply-To: <Y7fU4pRA+LHhsMKj@sol.localdomain>
From:   Boyang Xue <bxue@redhat.com>
Date:   Fri, 6 Jan 2023 19:10:04 +0800
Message-ID: <CAHLe9YamOY1UJ5Bq0w1ykmG47cztGP1U5CPPD-kiEWtEcFUKtg@mail.gmail.com>
Subject: Re: [PATCH v1] src/stat_test.c: add STATX_DIOALIGN support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, lczerner@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Eric,

Thanks for your suggestion! From the kernel source (
https://github.com/torvalds/linux/blob/1f5abbd77e2c1787e74b7c2caffac97def78ba52/block/bdev.c#L1089
)

    stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
    stat->dio_offset_align = bdev_logical_block_size(bdev);

I think that

stx_dio_mem_align=$(cat /sys/block/<dev>/queue/logical_block_size)
stx_dio_offset_align=$(($(cat /sys/block/vda/queue/dma_alignment)+1))

The output on my system is like

[root@localhost ~]# cat /sys/block/vda/queue/logical_block_size
512
[root@localhost ~]# echo $(($(cat /sys/block/<dev>/queue/dma_alignment)+1))
512

I have hacked <kernel source>/samples/vfs/test-statx.c like

[root@localhost ~]# git diff test-statx.c test-statx-mod.c
diff --git a/test-statx.c b/test-statx-mod.c
index 49c7a46..713d7b6 100644
--- a/test-statx.c
+++ b/test-statx-mod.c
@@ -107,6 +107,9 @@ static void dump_statx(struct statx *stx)
        printf("Device: %-15s", buffer);
        if (stx->stx_mask & STATX_INO)
                printf(" Inode: %-11llu", (unsigned long long) stx->stx_ino);
+       if (stx->stx_mask & STATX_DIOALIGN)
+               printf(" stx_dio_mem_align: %u", stx->stx_dio_mem_align);
+               printf(" stx_dio_offset_align: %u", stx->stx_dio_offset_align);
        if (stx->stx_mask & STATX_NLINK)
                printf(" Links: %-5u", stx->stx_nlink);
        if (stx->stx_mask & STATX_TYPE) {
@@ -218,7 +221,7 @@ int main(int argc, char **argv)
        struct statx stx;
        int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;

-       unsigned int mask = STATX_BASIC_STATS | STATX_BTIME;
+       unsigned int mask = STATX_BASIC_STATS | STATX_BTIME | STATX_DIOALIGN;

        for (argv++; *argv; argv++) {
                if (strcmp(*argv, "-F") == 0) {

and the output on my system is

[root@localhost ~]# ./test-statx-mod testfile
statx(testfile) = 0
results=3fff
  Size: 8388608         Blocks: 16384      IO Block: 4096    regular file
Device: fc:02           Inode: 586         stx_dio_mem_align: 512
stx_dio_offset_align: 512 Links: 1
Access: (0644/-rw-r--r--)  Uid:     0   Gid:     0
Access: 2023-01-06 04:59:46.967816162-0500
Modify: 2023-01-06 04:59:47.099816162-0500
Change: 2023-01-06 04:59:47.099816162-0500
 Birth: 2023-01-06 04:59:46.967816162-0500
Attributes: 0000000000000000 (........ ........ ........ ........
........ ..--.... ..---... .---.-..)

Notice stx_dio_mem_align and stx_dio_offset_align both are 512, so I
guess it shows STATX_DIOALIGN on my system works correctly.
Unfortunately, I am still unable to get my patch working, even with
your suggested fix, the stx_dio_mem_align and stx_dio_offset_align all
printed as 0.

I planned to test this functionality by hacking generic/423, which I
think is a good framework for doing basic statx() validation, like

ref_dio_mem_align=$(cat /sys/block/<dev>/queue/logical_block_size)
ref_dio_offset_align=$(($(cat /sys/block/<dev>/queue/dma_alignment)+1))
...
check_stat $TEST_DIR/$seq-file \
   stx_dio_mem_align=$ref_dio_mem_align \
   stx_dio_offset_align=$ref_dio_offset_align

I think this is adequate for a basic correctness test?

Thanks,
Boyang

On Fri, Jan 6, 2023 at 4:01 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hi Boyang,
>
> On Wed, Jan 04, 2023 at 12:28:01PM +0800, bxue@redhat.com wrote:
> > From: Boyang Xue <bxue@redhat.com>
> >
> > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > ---
> > Hi,
> >
> > The latest kernel has support for exposing direct I/O alignment
> > information via statx() by
> >
> > 825cf206ed51 statx: add direct I/O alignment information
> >
> > I'm trying to enhance xfstests/src/stat_test.c to support this
> > functionality, and the final goal is enhancing generic/423 to test it.
> >
> > I think I have made all the necessary change here, but it always prints
> > stx_dio_mem_align and stx_dio_offset_align as 0 (should be 512)
> >
> > [root@localhost repo_xfstests-dev]# src/stat_test -v
> > ../testfile stx_dio_offset_align=222
> >  - call statx ../testfile
> >  - call stat ../testfile
> >  - compare statx and stat
> >  - begin time 0.000000000
> >  -      btime 1672804449.041990601
> >  -      atime 1672804449.041990601
> >  -      mtime 1672804449.127990601
> >  -      ctime 1672804449.127990601
> >  - check stx_dio_offset_align=222
> > [!] stx_dio_offset_align differs, 0 != 222
> > Failed
> >
> >  src/stat_test.c | 10 ++++++++++
> >  src/statx.h     | 10 ++++++++--
> >  2 files changed, 18 insertions(+), 2 deletions(-)
> >
> > The kernel version in test is kernel-6.2.0-0.rc1.
> >
> > Could you suggest how to fix it please?
> >
> > Thanks,
> > Boyang
>
> Thanks for working on this!  One of the challenges with testing STATX_DIOALIGN
> is that it can only be usefully tested if DIO is supported, yet STATX_DIOALIGN
> is itself the way to check whether DIO is supported.  Another challenge is that
> without something to compare the alignments against, it's hard to know whether
> the correct values are being reported.  (A test could try to validate the values
> by attempting DIO, but the filesystem might fall back to buffered I/O for
> unsupported or misaligned DIO, which would be hard to distinguish from true DIO.
> Maybe something clever could be done with mincore() detect buffered I/O.)
>
> Is there a specific test that you're planning to add?  A test that would be at
> least somewhat useful would be to test that if STATX_DIOALIGN gives nonzero
> stx_dio_mem_align and stx_dio_offset_align, then DIO aligned to *only* those
> alignments doesn't return an error.
>
> Another possible test would to find a specific case where the DIO support and
> alignments can be determined by another method and compared to what
> STATX_DIOALIGN reports.  For example, if testing XFS, the XFS_IOC_DIOINFO ioctl
> can be used.  Or if the test just creates a filesystem with the default options
> and mounts it with the default options, it might just "know" that DIO is
> supported with logical_block_size alignment.
>
> Anyway, as for why your patch to stat_test.c doesn't work, it's because there's
> a bug in it.  Try the following:
>
> diff --git a/src/stat_test.c b/src/stat_test.c
> index cd38a54a..85d703a0 100644
> --- a/src/stat_test.c
> +++ b/src/stat_test.c
> @@ -570,6 +570,8 @@ static void check_field(const struct statx *stx, char *arg)
>         case stx_rdev_minor:
>         case stx_dev_major:
>         case stx_dev_minor:
> +       case stx_dio_mem_align:
> +       case stx_dio_offset_align:
>                 ucheck = strtoull(val, &p, 0);
>                 if (*p)
>                         bad_arg("Field '%s' requires unsigned integer\n", key);
> @@ -577,8 +579,6 @@ static void check_field(const struct statx *stx, char *arg)
>                       "%s differs, %llu != %llu\n", key, uval, ucheck);
>                 break;
>
> -       case stx_dio_mem_align:
> -       case stx_dio_offset_align:
>         case stx_atime_tv_sec:
>         case stx_atime_tv_nsec:
>         case stx_btime_tv_sec:
>

