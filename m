Return-Path: <SRS0=gkCv=YW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292EBCA9EAE
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Oct 2019 08:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67772086A
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Oct 2019 08:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZnrElwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfJ2Icr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:32:47 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40443 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfJ2Icr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Oct 2019 04:32:47 -0400
Received: by mail-yb1-f196.google.com with SMTP id d12so5071182ybn.7;
        Tue, 29 Oct 2019 01:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nnMDmWzdRua74WhW1znWEDFxaYIJkA0CCi+7fHZCsw=;
        b=FZnrElwVkKPYdsvvVE1HvXQnwu0TBhlgrfn17dyqrL+9OtwlFd1mA4I55XbHocTmtp
         vOeKxWB3JYVZUodswKZ6+yAL66lIBl/k6qipX+W2i0OtGkgfyCmgfoDTph57k/dlSD3H
         BqRtnIcVN+GSlMOzEpr/svnYrUISLvnymMDVigjyfz4Frdjpi5TAjxysxyFAmCy7r9ef
         w2dhm+Atn4AxHYOFlBazSgD8YON3S7OH4s6q+kUBTnEDwfz8rHiyCdmeCdu9wBNwEQ5j
         6J0ZVDqfW9WOvt8VF5HNyfgAygmlW+h1V+AxmUMhvoy1ENrpkT58rUHM2+MAN77l63Ac
         +QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nnMDmWzdRua74WhW1znWEDFxaYIJkA0CCi+7fHZCsw=;
        b=cfQb20b2HBp4Wt6m9xInJv8Km7fdcR70lBVGxRg5i4uB1PzPl3GmDHB331ZyyXU+mi
         yj0UchWGqJsog21ppZGTffClSWhKpwKV5W7q3VkhueTPUw+RysUDucdtB/kn2yJeQ07R
         qEdAUB5XxmSmXUU1Hb+Jpu0MnYAt/wTKkWSu5r7jUZ5pI2MUnHslijdABhEfc+7fai/8
         zt8dQaMOVup5CAdekGMr05ibCm71aTVx01w95dR/2ygKvxwd8Wq2M6McesFiykt12eZx
         TJzeTAx5N24pyERxZ8+U8e9dFqnxH58d56NAeP8AGmxEto0hhglLrHxpYvVHMebGxAam
         QJ+g==
X-Gm-Message-State: APjAAAVgmC2N963luxjyY3QQ+M5ImtcZ6X2xOPxf02EDZi/5tsCGje99
        Tzwc1wpl14wsmYrzb50Vz3M6yCckTRv/7zG4bwM=
X-Google-Smtp-Source: APXvYqxBJYDQNNwB3Vw2PPNFroWshODSE0YqiqrwoZqrg7SEsw3U5ATVH5P6XLv9FkBoPJYB5lf+acpLDdGuWi2Cjws=
X-Received: by 2002:a25:508d:: with SMTP id e135mr16578034ybb.144.1572337964260;
 Tue, 29 Oct 2019 01:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191029055713.28191-1-cgxu519@mykernel.net>
In-Reply-To: <20191029055713.28191-1-cgxu519@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 29 Oct 2019 10:32:32 +0200
Message-ID: <CAOQ4uxgzZHXOv7K++BArYmaTEHbYr5oCkgXw8WVUsQgh0uyqhg@mail.gmail.com>
Subject: Re: [PATCH] overlay/066: adjust test file size && add more test patterns
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

On Tue, Oct 29, 2019 at 7:57 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>

Can you please send the patch as plain/text.
Your mailer has sent it with quoted printable encoding and git am
fails to apply the patch:
https://lore.kernel.org/fstests/20191029055713.28191-1-cgxu519@mykernel.net/raw

> Make many small holes in 10M test file seems not very
> helpful for test coverage and it takes too much time
> on creating test files. So in order to improve test
> speed we adjust test file size to (10 * iosize) for
> iosize aligned hole files meanwhile add more test
> patterns for small random holes and small empty file.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  tests/overlay/066 | 89 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 22 deletions(-)
>
> diff --git a/tests/overlay/066 b/tests/overlay/066
> index 285a5aff..fb8f5e5c 100755
> --- a/tests/overlay/066
> +++ b/tests/overlay/066
> @@ -40,49 +40,82 @@ _require_scratch
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
>
>  lowerdir=$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
>  upperdir=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
>  testfile="copyup_sparse_test"
>
> -# Create a completely empty hole file(10M).
> -file_size=10240
> -$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_empty_holefile" \
> +# Create a small completely empty hole file(4K).
> +file_size=4
> +$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_empty_small_holefile" \
> +                >>$seqres.full
> +
> +# Create a big completely empty hole file(4M).
> +file_size=4096
> +$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_empty_big_holefile" \
>                  >>$seqres.full
>
> -# Create 2^0(K)..2^11(K) hole size test files(each 10M).
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
>         $XFS_IO_PROG -fc "truncate ${file_size}K" \
>                 "${lowerdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
>         while [ $pos -lt $max_pos ]; do
>                 $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" \
>                 "${lowerdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
> -               pos=`expr $pos + $iosize + $iosize`
> +               pos=$(($pos + $iosize * 2))
>         done
> -       iosize=`expr $iosize + $iosize`
> +       iosize=$(($iosize * 2))
>  done
>
> +# Create test file with many random small holes(hole size is between 4K and 512K),
> +# total file size is 10M.
> +
> +pos=4
> +max_pos=9216
> +file_size=10240
> +min_hole=4
> +max_hole=512
> +
> +$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_random_small_holefile" \
> +               >>$seqres.full
> +
> +while [ $pos -le $max_pos ]; do
> +       iosize=$(($RANDOM % ($max_hole - $min_hole) + $min_hole))
> +       $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" \
> +               "${lowerdir}/${testfile}_random_small_holefile" >>$seqres.full
> +       pos=$(($pos + $iosize * 2))
> +done
> +
> +
>  # Create test file with many random holes(hole size is between 1M and 5M),
>  # total file size is 100M.
>
> @@ -92,14 +125,14 @@ file_size=102400
>  min_hole=1024
>  max_hole=5120
>
> -$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_random_holefile" \
> +$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_random_big_holefile" \
>                 >>$seqres.full
>
>  while [ $pos -le $max_pos ]; do
>         iosize=$(($RANDOM % ($max_hole - $min_hole) + $min_hole))
>         $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" \
> -               "${lowerdir}/${testfile}_random_holefile" >>$seqres.full
> -       pos=`expr $pos + $iosize + $iosize`
> +               "${lowerdir}/${testfile}_random_big_holefile" >>$seqres.full
> +       pos=$(($pos + $iosize * 2))
>  done
>
>  _scratch_mount
> @@ -112,18 +145,30 @@ done
>  echo "Silence is golden"
>
>  # Check all copy-up files in upper layer.
> -iosize=1
> -while [ $iosize -le 2048 ]; do
> +min_iosize=1
> +max_iosize=2048

My intention was that you use those "constants" defined above when creating
the files, not that you re-define them when verifying the files.

> +iosize=$min_iosize
> +
> +while [ $iosize -le $max_iosize ]; do
>         diff "${lowerdir}/${testfile}_iosize${iosize}K_holefile" \
>                 "${upperdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full ||\
>                 echo "${upperdir}/${testfile}_iosize${iosize}K_holefile" copy up failed!
> -       iosize=`expr $iosize + $iosize`
> +       iosize=$(($iosize * 2))
>  done
>
> -diff "${lowerdir}/${testfile}_empty_holefile"  "${upperdir}/${testfile}_empty_holefile"  \
> -       >>$seqres.full || echo "${upperdir}/${testfile}_empty_holefile" copy up failed!
> -diff "${lowerdir}/${testfile}_random_holefile" "${upperdir}/${testfile}_random_holefile" \
> -       >>$seqres.full || echo "${upperdir}/${testfile}_random_holefile" copy up failed!
> +# Check empty hole files
> +diff "${lowerdir}/${testfile}_empty_small_holefile" "${upperdir}/${testfile}_empty_small_holefile"  \
> +       >>$seqres.full || echo "${upperdir}/${testfile}_empty_small_holefile" copy up failed!
> +
> +diff "${lowerdir}/${testfile}_empty_big_holefile" "${upperdir}/${testfile}_empty_big_holefile"  \
> +       >>$seqres.full || echo "${upperdir}/${testfile}_empty_big_holefile" copy up failed!
> +
> +# Check random hole files
> +diff "${lowerdir}/${testfile}_random_small_holefile" "${upperdir}/${testfile}_random_small_holefile" \
> +       >>$seqres.full || echo "${upperdir}/${testfile}_random_small_holefile" copy up failed!
> +
> +diff "${lowerdir}/${testfile}_random_big_holefile" "${upperdir}/${testfile}_random_big_holefile" \
> +       >>$seqres.full || echo "${upperdir}/${testfile}_random_big_holefile" copy up failed!
>

This would be much nicer with

for name in empty_small empty_big random_small random_big; do
...


And I would still like to test the patch before I ACK it, so please
send the patch
as attachment or re-send in plain text encoding.

Thanks,
Amir.
