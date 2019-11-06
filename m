Return-Path: <SRS0=RANT=Y6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70344C5DF62
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Nov 2019 10:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336EC2173B
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Nov 2019 10:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTJ8K9Wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKFKCJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:02:09 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36661 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKFKCI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Nov 2019 05:02:08 -0500
Received: by mail-yb1-f195.google.com with SMTP id v17so3697275ybs.3;
        Wed, 06 Nov 2019 02:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZbuyOn5g+YdNFfP1XvSH9DPQV3l3rGtyJ7eZ2iitAA=;
        b=sTJ8K9WiTuK9z884R685saV3bKvFQzD6hJiyRMv7s5jB7k/kyO6xEpy5vF4a36jqqJ
         rLFKtP7LX2kykHKVbCTfXD0CDSsyKEvOBD35pYUTL9LY3j7IeGIIjIBKX88tktfX9x+X
         mQN3ssq7Rtf2iMKGpNoR7Gn2tAhsdbpPKGKvs/tSzK7+OuXaZOYtYPJJ7Je8SDz9Ph96
         BWxpXMFwGxv92r/EMGLG3MW7TXoutR834SfTTvzRb7pdhhI/FaR+3oAcqmpFWVYq+fzh
         3nhW+FkhTOMK1U3ucn1svwgkBHEBaBszsRyC1DfxJpNCmx4Cgjjl6aYlzk5MS8ZmAVTY
         0BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZbuyOn5g+YdNFfP1XvSH9DPQV3l3rGtyJ7eZ2iitAA=;
        b=JMUNpxdMjdJ0QCKbsDNYTYBS5UktV53/ZJWSUfMkQcahVUTPOk9auuB4dB+A3pxdKJ
         B4wCTV7F6FrZ8eILjtcvSGMYfT1ihC33Hnmotj8a50z9Te0twI3DnXMig5Pi91FGUcP0
         kxFdy/Th6NomZrzJgApUNoFLRB6IfCndKzcnDmCiKHVfGNuamKR+vjQtebze+paMtXci
         iIFNjl/C+Wzk60yjrg/qV62zfvh46CiXBeSjiORdXaBQZk0QFtwINVGOxLHHApkmaW2Y
         TP0TFqokSyTh2wIt/1Ptm/ZOUo+wGAfxEerELSfW7yeswf/gt6rt8b0+DhS3feonWM3e
         S7SQ==
X-Gm-Message-State: APjAAAWRMDtU339qIDc0H6utt7U9odZDn5zz/5wsRoMbdDbVm+rbzfUh
        YYpC6VE93m3Gx3Ett04gkXnW1/LNbrw9aM2ceMI=
X-Google-Smtp-Source: APXvYqyTbFbyi25dX8ZHZNNaEEQeofIT/XXR7EvQHPIbZFeqhRLx24q1O4acBV4f2lZKifGwtJ1Bbd19ZnCEVJnyNak=
X-Received: by 2002:a25:1444:: with SMTP id 65mr1221121ybu.132.1573034525849;
 Wed, 06 Nov 2019 02:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20191106073945.12015-1-cgxu519@mykernel.net>
In-Reply-To: <20191106073945.12015-1-cgxu519@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 6 Nov 2019 12:01:54 +0200
Message-ID: <CAOQ4uxgBO6zZVJsa2uor5kwa1jp05Xrte6fifZdOsX=yF=v0-g@mail.gmail.com>
Subject: Re: [PATCH v3] overlay/066: adjust test file size && add more test patterns
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     fstests <fstests@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 6, 2019 at 9:40 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Making many small holes in 10M test file seems not very
> helpful for test coverage and it takes too much time on
> creating test files. In order to improve test speed we
> adjust test file size to (10 * iosize) for iosize aligned
> hole files and meanwhile add more test patterns for small
> random holes and small empty file.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Please send me a plain text version of the patch so I can test it.

Thanks,
Amir.

> ---
> v1->v2:
> - Check result in one diff command.
> - Print more information(file layout) to full log when test failed.
> - Truncate test file name.
>
> v2->v3:
> - Print diff result to golden output.
> - Record xfs_io command to full log.
> - Set initial pos and max_pos using calculation for random hole file.
>
>  tests/overlay/066 | 120 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 83 insertions(+), 37 deletions(-)
>
> diff --git a/tests/overlay/066 b/tests/overlay/066
> index 285a5aff..95f6576c 100755
> --- a/tests/overlay/066
> +++ b/tests/overlay/066
> @@ -40,90 +40,136 @@ _require_scratch
>  # Remove all files from previous tests
>  _scratch_mkfs
>
> -# We have totally 14 test files in this test.
> +# We have totally 16 test files in this test.
>  # The detail as below:
> -# 1 empty file(10M) + 2^0(K)..2^11(K) hole size files(each 10M) + 1 random hole size file(100M).
> +# 1 small empty file 4K
> +# 1 big empty file 4M
> +# 1 small random hole file 10M
> +# 1 big random hole file 100M
> +#
> +# 12 files with variant iosize aligned holes.
> +# 2^0(K)..2^11(K) hole size files(file size = 10 * iosize)
>  #
>  # Considering both upper and lower fs will fill zero when copy-up
>  # hole area in the file, this test at least requires double disk
>  # space of the sum of above test files' size.
>
> -_require_fs_space $OVL_BASE_SCRATCH_MNT $(((10*1024*13 + 100*1024*1) * 2))
> +_require_fs_space $OVL_BASE_SCRATCH_MNT $((((4) + (4096) + (10 * 1024) \
> +                + (100 * 1024) + (10 * (1 + 2048) * 12 / 2)) * 2))
> +
> +do_cmd()
> +{
> +       echo $@ >>$seqres.full
> +       eval $@ >>$seqres.full
> +}
>
>  lowerdir=$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
>  upperdir=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
>  testfile="copyup_sparse_test"
>
> -# Create a completely empty hole file(10M).
> -file_size=10240
> -$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_empty_holefile" \
> -                >>$seqres.full
> +# Create a small completely empty hole file(4K).
> +file_size=4
> +do_cmd $XFS_IO_PROG -fc "\"truncate ${file_size}K\"" \
> +                       "${lowerdir}/${testfile}_empty_small"
>
> -# Create 2^0(K)..2^11(K) hole size test files(each 10M).
> +# Create a big completely empty hole file(4M).
> +file_size=4096
> +do_cmd $XFS_IO_PROG -fc "\"truncate ${file_size}K\"" \
> +                       "${lowerdir}/${testfile}_empty_big"
> +
> +# Create 2^0(K)..2^11(K) hole size test files(file size = 10 * iosize).
>  #
>  # The pattern is like below, both hole and data are equal to
>  # iosize except last hole.
>  #
>  # |-- hole --|-- data --| ... |-- data --|-- hole --|
>
> -iosize=1
> +min_iosize=1
>  max_iosize=2048
> -file_size=10240
> -max_pos=`expr $file_size - $max_iosize`
> +iosize=$min_iosize
>
>  while [ $iosize -le $max_iosize ]; do
> +       file_size=$(($iosize * 10))
> +       max_pos=$(($file_size - $iosize))
>         pos=$iosize
> -       $XFS_IO_PROG -fc "truncate ${file_size}K" \
> -               "${lowerdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
> +       do_cmd $XFS_IO_PROG -fc "\"truncate ${file_size}K\"" \
> +                               "${lowerdir}/${testfile}_iosize${iosize}K"
> +       echo -e "\niosize=${iosize}K hole test write scenarios ---\n" >>$seqres.full
>         while [ $pos -lt $max_pos ]; do
> -               $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" \
> -               "${lowerdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
> -               pos=`expr $pos + $iosize + $iosize`
> +               do_cmd $XFS_IO_PROG -fc "\"pwrite ${pos}K ${iosize}K\"" \
> +                                       "${lowerdir}/${testfile}_iosize${iosize}K"
> +               pos=$(($pos + $iosize * 2))
>         done
> -       iosize=`expr $iosize + $iosize`
> +       iosize=$(($iosize * 2))
> +done
> +echo >>$seqres.full
> +
> +# Create test file with many random small holes(hole size is between 4K and 512K),
> +# total file size is 10M.
> +
> +file_size=10240
> +min_hole=4
> +max_hole=512
> +pos=$min_hole
> +max_pos=$(($file_size - 2*$max_hole))
> +
> +do_cmd $XFS_IO_PROG -fc "\"truncate ${file_size}K\"" \
> +                       "${lowerdir}/${testfile}_random_small"
> +
> +echo -e "\nSmall random hole test write scenarios ---\n" >>$seqres.full
> +while [ $pos -le $max_pos ]; do
> +       iosize=$(($RANDOM % ($max_hole - $min_hole) + $min_hole))
> +       do_cmd $XFS_IO_PROG -fc "\"pwrite ${pos}K ${iosize}K\"" \
> +               "${lowerdir}/${testfile}_random_small"
> +       pos=$(($pos + $iosize * 2))
>  done
> +echo >>$seqres.full
> +
>
>  # Create test file with many random holes(hole size is between 1M and 5M),
>  # total file size is 100M.
>
> -pos=2048
> -max_pos=81920
>  file_size=102400
>  min_hole=1024
>  max_hole=5120
> +pos=$min_hole
> +max_hole=$(($file_size - 2*$max_hole))
>
> -$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_random_holefile" \
> -               >>$seqres.full
> +do_cmd $XFS_IO_PROG -fc "\"truncate ${file_size}K\"" \
> +                       "${lowerdir}/${testfile}_random_big"
>
> +echo -e "\nBig random hole test write scenarios ---\n" >>$seqres.full
>  while [ $pos -le $max_pos ]; do
>         iosize=$(($RANDOM % ($max_hole - $min_hole) + $min_hole))
> -       $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" \
> -               "${lowerdir}/${testfile}_random_holefile" >>$seqres.full
> -       pos=`expr $pos + $iosize + $iosize`
> +       do_cmd $XFS_IO_PROG -fc "\"pwrite ${pos}K ${iosize}K\"" \
> +                               "${lowerdir}/${testfile}_random_big"
> +       pos=$(($pos + $iosize * 2))
>  done
> +echo >>$seqres.full
>
>  _scratch_mount
>
>  # Open the test files, no errors are expected.
> +echo -e "\nDoing copy-up...\n" >>$seqres.full
>  for f in $SCRATCH_MNT/*; do
> -       $XFS_IO_PROG -c "open" $f >>$seqres.full
> +       do_cmd $XFS_IO_PROG -c "open" $f
>  done
>
>  echo "Silence is golden"
>
>  # Check all copy-up files in upper layer.
> -iosize=1
> -while [ $iosize -le 2048 ]; do
> -       diff "${lowerdir}/${testfile}_iosize${iosize}K_holefile" \
> -               "${upperdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full ||\
> -               echo "${upperdir}/${testfile}_iosize${iosize}K_holefile" copy up failed!
> -       iosize=`expr $iosize + $iosize`
> -done
> -
> -diff "${lowerdir}/${testfile}_empty_holefile"  "${upperdir}/${testfile}_empty_holefile"  \
> -       >>$seqres.full || echo "${upperdir}/${testfile}_empty_holefile" copy up failed!
> -diff "${lowerdir}/${testfile}_random_holefile" "${upperdir}/${testfile}_random_holefile" \
> -       >>$seqres.full || echo "${upperdir}/${testfile}_random_holefile" copy up failed!
> +diff -qr ${upperdir} ${lowerdir} | tee -a $seqres.full
> +if [ $? -ne 0 ]; then
> +       echo "Copy-up failed!!!"
> +
> +       echo "\n----------------------------------------" >>$seqres.full
> +       echo -e "The layout of files in lowerdir\n" >>$seqres.full
> +       do_cmd $FILEFRAG_PROG -k -e $lowerdir/*
> +       echo "\n----------------------------------------" >>$seqres.full
> +       echo -e "The layer of files in upperdir\n" >>$seqres.full
> +       do_cmd $FILEFRAG_PROG -k -e $upperdir/*
> +
> +fi
>
>  # success, all done
>  status=0
> --
> 2.20.1
>
>
>
