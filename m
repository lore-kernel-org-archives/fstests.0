Return-Path: <SRS0=J9/m=4V=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E987C3F2CE
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Mar 2020 18:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41CD21775
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Mar 2020 18:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUSV2Bbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgCDS2w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:28:52 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45964 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDS2w (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Mar 2020 13:28:52 -0500
Received: by mail-io1-f68.google.com with SMTP id w9so3467222iob.12
        for <fstests@vger.kernel.org>; Wed, 04 Mar 2020 10:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVzTWAz/Qc2Pq8HVjSAe4GTrCzoJVPlAvgsjRpn7uyA=;
        b=aUSV2BbpreNBt7qodDeR0n/F/4KyRJZ4cvBfQuBLC1HIrC43dBNckVdUkq1dmMxDbj
         lq4ZLoo/VCGYExl8VytKLIU6rZngO85zyxBtlw7EFEQyv/LXnIYShB5K1625bfgEtY2L
         NL/hjlMtJGQyqw2IUYjyukSDFbjnQ6zF5ogIQxVwkEc3rLHvcb0yPemESJt5PI3c/Bun
         ff0WvM8DhDiAEKOvSfPM6mfNCc8DFDGEhbN/QVzyStJlc1q0j5C4ti0bvWDw2ZBWCD7l
         nB844iYIOCX4v/jFQ7fcBZoS0zO8lBPAlw7GLvUkcRYk2GypG6gMLvCDueEi/6IeoLhM
         uL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVzTWAz/Qc2Pq8HVjSAe4GTrCzoJVPlAvgsjRpn7uyA=;
        b=gQsu5dw3bKkhGZ4fdwqoVcLN9lBKv9zXlLsiFpGTsGTnwYPdynyI8uYh9oZzatkUG8
         NNd2fEtJBsZpgw9kmrXiveZJdR+Q3XvcXzd0VC5Hl06TXzJT6bM4hc2SbHIBwUN8ZZLi
         kfLpdXdSGAuESJi56pidQDteFesaej4pXGtO34PiTtwt4j6eVaMipQZyLifhQ8C0vjrs
         lYVufd9X3QNR20jtuoKx0AyjMDBjcCsmQ/JtEUMFT4AU7mSW9o5P8nZaSpKZ+bEDfXd8
         YcwUHbs7Lgo6GBF281g5Q3Sb5k0uZP7FecqPzcH4OMzk66/1D2cn1Yx7btVF42TBjYdX
         hEOQ==
X-Gm-Message-State: ANhLgQ0ZlPTBBubuuSHFT8Nyn7L7IJJ14+ZPBe6JP1jE3EX+ZSPr8zRd
        5Ixoq91jXh5WD6bHUM31XmbuGLZ053dCIzZavuM=
X-Google-Smtp-Source: ADFU+vvkhcDIj5lvnCzrSESh86+VyA3dYCwjkJGaNqN3x/vbMIUgCjK1qZi/LuaPQqKx/RIsA9RGJ2oDJYGXZXept/I=
X-Received: by 2002:a5d:8f06:: with SMTP id f6mr3379314iof.137.1583346531492;
 Wed, 04 Mar 2020 10:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20200304161120.25764-1-lhenriques@suse.com>
In-Reply-To: <20200304161120.25764-1-lhenriques@suse.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 Mar 2020 20:28:40 +0200
Message-ID: <CAOQ4uxjZTV6oZ426WSemigcaT=avF8V19bJU45L9=CHH8ZsFzQ@mail.gmail.com>
Subject: Re: [PATCH] generic/258: check filesystem support for negative timestamps
To:     Luis Henriques <lhenriques@suse.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 4, 2020 at 6:11 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> Some filesystems do not support negative c/m/atime timestamps.  And for
> these filesystems, generic/258 will fail.  Since there's currently no way
> to check sb->s_time_min from userspace, this patch adds a new common/rc
> function _require_negative_timestamps() that will _notrun depending on the
> $FSTYP variable.
>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>

Looks fine,

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Hi!
>
> I'm only adding 'ceph' to the _require_negative_timestamps() case because
> that was the only filesystem with s_time_min = 0 that I was able to test.
> However, a simple grep indicates there are a few other filesystems that
> would also be required there (e.g. nfs version < 4).
>
> Cheers,
> --
> Luis
>
>  common/rc         | 8 ++++++++
>  tests/generic/258 | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/common/rc b/common/rc
> index 0306e93cb1ca..067f30cecde7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4157,6 +4157,14 @@ _check_xfs_scrub_does_unicode() {
>         return 0
>  }
>
> +_require_negative_timestamps() {
> +       case "$FSTYP" in
> +       ceph)
> +               _notrun "$FSTYP does not support negative timestamps"
> +               ;;
> +       esac
> +}
> +
>  init_rc
>
>  ################################################################################
> diff --git a/tests/generic/258 b/tests/generic/258
> index 68b8155d4a9f..dab1a476ed20 100755
> --- a/tests/generic/258
> +++ b/tests/generic/258
> @@ -30,6 +30,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> +_require_negative_timestamps
>
>  TESTFILE=$TEST_DIR/timestamp-test.txt
>
