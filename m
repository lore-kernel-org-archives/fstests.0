Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884E5C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 15:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CCE61183
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 15:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhJ2PvI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Oct 2021 11:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhJ2PvH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 29 Oct 2021 11:51:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E94D60F9C;
        Fri, 29 Oct 2021 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635522519;
        bh=FyENcjSVUo6+2Xnbq2uR2yj9fgaufDpbJmK1Hnb14gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3ESkUMZymD4M2T36UQbn+SWhEKc2twG4eNurZHpU2z+Cy+tX5g+e+EJuPyOCZqEm
         cReMxL3Bd4z8MHdFX0OcsHE/tZ5zqMZ5NfT3qX4bOahOfG1c3CHKQXC+6R4wBO8UDS
         pkznb/mNU6Eb4KoyE/vNZeX0t+ikhdN3/3yWnhGW0MDLcr7c0dQyTMElr53/C/tLXM
         1GEedSL3M0ziJ38wk7LmTP7vF/1PpZQzX5FIBXeBXT17fjZZo/VKLXt6qnljVCmpxT
         VRc9H1sAuRlvqz23rIhLSFdD18QFAcoJfT42VBwIuPINbXizVuc4D5SmrjamYZIEtE
         H4r8gzP7kUkIA==
Date:   Fri, 29 Oct 2021 08:48:38 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] generic/138,139,140: fix the name for check file
Message-ID: <20211029154838.GT24282@magnolia>
References: <20211029065943.3556529-1-ruansy.fnst@fujitsu.com>
 <20211029065943.3556529-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029065943.3556529-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 29, 2021 at 02:59:41PM +0800, Shiyang Ruan wrote:
> The original 'file3' is used to check if the result after operation on
> file2 is correct.  So, rename it to be 'file2.chk' to make it easier to
> understand.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

LGTM,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/138     | 54 +++++++++++++++++++++----------------------
>  tests/generic/138.out |  8 +++----
>  tests/generic/139     | 54 +++++++++++++++++++++----------------------
>  tests/generic/139.out |  8 +++----
>  tests/generic/140     | 54 +++++++++++++++++++++----------------------
>  tests/generic/140.out |  8 +++----
>  6 files changed, 93 insertions(+), 93 deletions(-)
> 
> diff --git a/tests/generic/138 b/tests/generic/138
> index 1037ed3e..d061ac34 100755
> --- a/tests/generic/138
> +++ b/tests/generic/138
> @@ -35,37 +35,37 @@ echo "Create the original files"
>  blksz=65536
>  _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file1 >> $seqres.full
>  _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
> -_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
> +_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
>  _test_cycle_mount
>  
>  echo "Compare files"
>  md5sum $testdir/file1 | _filter_test_dir
>  md5sum $testdir/file2 | _filter_test_dir
> -md5sum $testdir/file3 | _filter_test_dir
> +md5sum $testdir/file2.chk | _filter_test_dir
>  
> -cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 do not match"
> -cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 do not match"
> -cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 do not match"
> +cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 do not match"
> +cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk do not match"
> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file1 and file2.chk do not match"
>  
>  echo "pagecache CoW the second file"
>  _pwrite_byte 0x62 0 17 $testdir/file2 >> $seqres.full
> -_pwrite_byte 0x62 0 17 $testdir/file3 >> $seqres.full
> +_pwrite_byte 0x62 0 17 $testdir/file2.chk >> $seqres.full
>  
>  _pwrite_byte 0x62 $((blksz * 16 - 34)) 17 $testdir/file2 >> $seqres.full
> -_pwrite_byte 0x62 $((blksz * 16 - 34)) 17 $testdir/file3 >> $seqres.full
> +_pwrite_byte 0x62 $((blksz * 16 - 34)) 17 $testdir/file2.chk >> $seqres.full
>  
>  _pwrite_byte 0x62 $((blksz * 48 - 8)) 17 $testdir/file2 >> $seqres.full
> -_pwrite_byte 0x62 $((blksz * 48 - 8)) 17 $testdir/file3 >> $seqres.full
> +_pwrite_byte 0x62 $((blksz * 48 - 8)) 17 $testdir/file2.chk >> $seqres.full
>  _test_cycle_mount
>  
>  echo "Compare files"
>  md5sum $testdir/file1 | _filter_test_dir
>  md5sum $testdir/file2 | _filter_test_dir
> -md5sum $testdir/file3 | _filter_test_dir
> +md5sum $testdir/file2.chk | _filter_test_dir
>  
> -cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 do not match (intentional)"
> -cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 do not match (intentional)"
> -cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 do not match"
> +cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 do not match (intentional)"
> +cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk do not match (intentional)"
> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk do not match"
>  
>  echo "Compare the CoW'd section to the before file"
>  _compare_range $testdir/file1 0 $testdir/file2 0 17 \
> @@ -80,47 +80,47 @@ _compare_range  $testdir/file1 $((blksz * 48 - 8)) \
>         || echo "End sections do not match (intentional)"
>  
>  echo "Compare the CoW'd section to the after file"
> -_compare_range $testdir/file2 0 $testdir/file3 0 17 \
> +_compare_range $testdir/file2 0 $testdir/file2.chk 0 17 \
>         || echo "Start sections do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 16 - 34)) \
> -		$testdir/file3 $((blksz * 16 - 34)) 17 \
> +		$testdir/file2.chk $((blksz * 16 - 34)) 17 \
>         || echo "Middle sections do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 48 - 8)) \
> -		$testdir/file3 $((blksz * 48 - 8)) 17 \
> +		$testdir/file2.chk $((blksz * 48 - 8)) 17 \
>         || echo "End sections do not match"
>  
>  echo "Compare the not CoW'd sections"
>  _compare_range $testdir/file1 18 $testdir/file2 18 17 \
> -       || echo "Start sections of 1-2 do not match"
> +       || echo "Start sections of file1 and file2 do not match"
>  
> -_compare_range $testdir/file2 18 $testdir/file3 18 17 \
> -       || echo "Start sections of 2-3 do not match"
> +_compare_range $testdir/file2 18 $testdir/file2.chk 18 17 \
> +       || echo "Start sections of file2 and file2.chk do not match"
>  
>  _compare_range  $testdir/file1 $((blksz * 16 - 17)) \
>  		$testdir/file2 $((blksz * 16 - 17)) 82 \
> -       || echo "Middle sections of 1-2 do not match"
> +       || echo "Middle sections of file1 and file2 do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 16 - 17)) \
> -		$testdir/file3 $((blksz * 16 - 17)) 82 \
> -       || echo "Middle sections of 2-3 do not match"
> +		$testdir/file2.chk $((blksz * 16 - 17)) 82 \
> +       || echo "Middle sections of file2 and file2.chk do not match"
>  
>  _compare_range  $testdir/file1 $((blksz * 48 - 108)) \
>  		$testdir/file2 $((blksz * 48 - 108)) 100 \
> -       || echo "End sections of 1-2 do not match"
> +       || echo "End sections of file1 and file2 do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 48 - 108)) \
> -		$testdir/file3 $((blksz * 48 - 108)) 100 \
> -       || echo "End sections of 2-3 do not match"
> +		$testdir/file2.chk $((blksz * 48 - 108)) 100 \
> +       || echo "End sections of file2 and file2.chk do not match"
>  
>  _compare_range  $testdir/file1 $((blksz * 14)) \
>  		$testdir/file2 $((blksz * 14)) $blksz \
> -       || echo "Untouched sections of 1-2 do not match"
> +       || echo "Untouched sections of file1 and file2 do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 14)) \
> -		$testdir/file3 $((blksz * 14)) $blksz \
> -       || echo "Untouched sections of 2-3 do not match"
> +		$testdir/file2.chk $((blksz * 14)) $blksz \
> +       || echo "Untouched sections of file2 and file2.chk do not match"
>  
>  # success, all done
>  status=0
> diff --git a/tests/generic/138.out b/tests/generic/138.out
> index b0cafabe..60cd876e 100644
> --- a/tests/generic/138.out
> +++ b/tests/generic/138.out
> @@ -3,14 +3,14 @@ Create the original files
>  Compare files
>  60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-138/file1
>  60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-138/file2
> -60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-138/file3
> +60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-138/file2.chk
>  pagecache CoW the second file
>  Compare files
>  60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-138/file1
>  4a879c2f322121f6f4b8ebede1909a7c  TEST_DIR/test-138/file2
> -4a879c2f322121f6f4b8ebede1909a7c  TEST_DIR/test-138/file3
> -Files 1-2 do not match (intentional)
> -Files 1-3 do not match (intentional)
> +4a879c2f322121f6f4b8ebede1909a7c  TEST_DIR/test-138/file2.chk
> +file1 and file2 do not match (intentional)
> +file1 and file2.chk do not match (intentional)
>  Compare the CoW'd section to the before file
>  Start sections do not match (intentional)
>  Middle sections do not match (intentional)
> diff --git a/tests/generic/139 b/tests/generic/139
> index 6422f66a..0bbc222c 100755
> --- a/tests/generic/139
> +++ b/tests/generic/139
> @@ -36,37 +36,37 @@ echo "Create the original files"
>  blksz=65536
>  _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file1 >> $seqres.full
>  _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
> -_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
> +_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
>  _test_cycle_mount
>  
>  echo "Compare files"
>  md5sum $testdir/file1 | _filter_test_dir
>  md5sum $testdir/file2 | _filter_test_dir
> -md5sum $testdir/file3 | _filter_test_dir
> +md5sum $testdir/file2.chk | _filter_test_dir
>  
> -cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 should match"
> -cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 should match"
> -cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 should match"
> +cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 should match"
> +cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk should match"
> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk should match"
>  
>  echo "directio CoW the second file"
>  _pwrite_byte 0x62 0 $blksz $testdir/file2 -d >> $seqres.full
> -_pwrite_byte 0x62 0 $blksz $testdir/file3 -d >> $seqres.full
> +_pwrite_byte 0x62 0 $blksz $testdir/file2.chk -d >> $seqres.full
>  
>  _pwrite_byte 0x62 $((blksz * 16 - 512)) 512 $testdir/file2 -d >> $seqres.full
> -_pwrite_byte 0x62 $((blksz * 16 - 512)) 512 $testdir/file3 -d >> $seqres.full
> +_pwrite_byte 0x62 $((blksz * 16 - 512)) 512 $testdir/file2.chk -d >> $seqres.full
>  
>  _pwrite_byte 0x62 $((blksz * 48)) $blksz $testdir/file2 -d >> $seqres.full
> -_pwrite_byte 0x62 $((blksz * 48)) $blksz $testdir/file3 -d >> $seqres.full
> +_pwrite_byte 0x62 $((blksz * 48)) $blksz $testdir/file2.chk -d >> $seqres.full
>  _test_cycle_mount
>  
>  echo "Compare files"
>  md5sum $testdir/file1 | _filter_test_dir
>  md5sum $testdir/file2 | _filter_test_dir
> -md5sum $testdir/file3 | _filter_test_dir
> +md5sum $testdir/file2.chk | _filter_test_dir
>  
> -cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 should not match (intentional)"
> -cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 should not match (intentional)"
> -cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 should match"
> +cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 should not match (intentional)"
> +cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk should not match (intentional)"
> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk should match"
>  
>  echo "Compare the CoW'd section to the before file"
>  _compare_range $testdir/file1 0 $testdir/file2 0 $blksz \
> @@ -81,46 +81,46 @@ _compare_range  $testdir/file1 $((blksz * 48 - 512)) \
>         || echo "End sections do not match (intentional)"
>  
>  echo "Compare the CoW'd section to the after file"
> -_compare_range $testdir/file2 0 $testdir/file3 0 $blksz \
> +_compare_range $testdir/file2 0 $testdir/file2.chk 0 $blksz \
>         || echo "Start sections do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 16 - 512)) \
> -		$testdir/file3 $((blksz * 16 - 512)) 512 \
> +		$testdir/file2.chk $((blksz * 16 - 512)) 512 \
>         || echo "Middle sections do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 48 - 512)) \
> -		$testdir/file3 $((blksz * 48 - 512)) $blksz \
> +		$testdir/file2.chk $((blksz * 48 - 512)) $blksz \
>         || echo "End sections do not match"
>  
>  echo "Compare the not CoW'd sections"
>  _compare_range $testdir/file1 $blksz $testdir/file2 $blksz 512 \
> -       || echo "Start sections of 1-2 do not match"
> -_compare_range $testdir/file2 $blksz $testdir/file3 $blksz 512 \
> -       || echo "Start sections of 2-3 do not match"
> +       || echo "Start sections of file1 and file2 do not match"
> +_compare_range $testdir/file2 $blksz $testdir/file2.chk $blksz 512 \
> +       || echo "Start sections of file2 and file2.chk do not match"
>  
>  _compare_range  $testdir/file1 $((blksz * 16 - 1024)) \
>  		$testdir/file2 $((blksz * 16 - 1024)) 512 \
> -       || echo "Middle sections of 1-2 do not match"
> +       || echo "Middle sections of file1 and file2 do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 16 - 1024)) \
> -		$testdir/file3 $((blksz * 16 - 1024)) 512 \
> -       || echo "Middle sections of 2-3 do not match"
> +		$testdir/file2.chk $((blksz * 16 - 1024)) 512 \
> +       || echo "Middle sections of file2 and file2.chk do not match"
>  
>  _compare_range  $testdir/file1 $((blksz * 48 - 1024)) \
>  		$testdir/file2 $((blksz * 48 - 1024)) 512 \
> -       || echo "End sections of 1-2 do not match"
> +       || echo "End sections of file1 and file2 do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 48 - 1024)) \
> -		$testdir/file3 $((blksz * 48 - 1024)) 512 \
> -       || echo "End sections of 2-3 do not match"
> +		$testdir/file2.chk $((blksz * 48 - 1024)) 512 \
> +       || echo "End sections of file2 and file2.chk do not match"
>  
>  _compare_range  $testdir/file1 $((blksz * 16)) \
>  		$testdir/file2 $((blksz * 16)) 512 \
> -       || echo "Untouched sections of 1-2 do not match"
> +       || echo "Untouched sections of file1 and file2 do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 16)) \
> -		$testdir/file3 $((blksz * 16)) 512 \
> -       || echo "Untouched sections of 2-3 do not match"
> +		$testdir/file2.chk $((blksz * 16)) 512 \
> +       || echo "Untouched sections of file2 and file2.chk do not match"
>  
>  # success, all done
>  status=0
> diff --git a/tests/generic/139.out b/tests/generic/139.out
> index 28d04f5f..56d6c9f9 100644
> --- a/tests/generic/139.out
> +++ b/tests/generic/139.out
> @@ -3,14 +3,14 @@ Create the original files
>  Compare files
>  60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-139/file1
>  60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-139/file2
> -60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-139/file3
> +60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-139/file2.chk
>  directio CoW the second file
>  Compare files
>  60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-139/file1
>  ff5626fb6c71b242d6b1a43de25c9a85  TEST_DIR/test-139/file2
> -ff5626fb6c71b242d6b1a43de25c9a85  TEST_DIR/test-139/file3
> -Files 1-2 should not match (intentional)
> -Files 1-3 should not match (intentional)
> +ff5626fb6c71b242d6b1a43de25c9a85  TEST_DIR/test-139/file2.chk
> +file1 and file2 should not match (intentional)
> +file1 and file2.chk should not match (intentional)
>  Compare the CoW'd section to the before file
>  Start sections do not match (intentional)
>  Middle sections do not match (intentional)
> diff --git a/tests/generic/140 b/tests/generic/140
> index 6cba5791..52cf07dc 100755
> --- a/tests/generic/140
> +++ b/tests/generic/140
> @@ -35,37 +35,37 @@ echo "Create the original files"
>  blksz=65536
>  _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file1 >> $seqres.full
>  _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
> -_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
> +_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
>  _test_cycle_mount
>  
>  echo "Compare files"
>  md5sum $testdir/file1 | _filter_test_dir
>  md5sum $testdir/file2 | _filter_test_dir
> -md5sum $testdir/file3 | _filter_test_dir
> +md5sum $testdir/file2.chk | _filter_test_dir
>  
> -cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 do not match"
> -cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 do not match"
> -cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 do not match"
> +cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 do not match"
> +cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk do not match"
> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk do not match"
>  
>  echo "mmap CoW the second file"
>  _mwrite_byte 0x62 0 17 $((blksz * 48 - 3)) $testdir/file2 >> $seqres.full
> -_mwrite_byte 0x62 0 17 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
> +_mwrite_byte 0x62 0 17 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
>  
>  _mwrite_byte 0x62 $((blksz * 16 - 34)) 17 $((blksz * 48 - 3)) $testdir/file2 >> $seqres.full
> -_mwrite_byte 0x62 $((blksz * 16 - 34)) 17 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
> +_mwrite_byte 0x62 $((blksz * 16 - 34)) 17 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
>  
>  _mwrite_byte 0x62 $((blksz * 48 - 20)) 17 $((blksz * 48 - 3)) $testdir/file2 >> $seqres.full
> -_mwrite_byte 0x62 $((blksz * 48 - 20)) 17 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
> +_mwrite_byte 0x62 $((blksz * 48 - 20)) 17 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
>  _test_cycle_mount
>  
>  echo "Compare files"
>  md5sum $testdir/file1 | _filter_test_dir
>  md5sum $testdir/file2 | _filter_test_dir
> -md5sum $testdir/file3 | _filter_test_dir
> +md5sum $testdir/file2.chk | _filter_test_dir
>  
> -cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 do not match (intentional)"
> -cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 do not match (intentional)"
> -cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 do not match"
> +cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 do not match (intentional)"
> +cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk do not match (intentional)"
> +cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk do not match"
>  
>  echo "Compare the CoW'd section to the before file"
>  _compare_range $testdir/file1 0 $testdir/file2 0 17 \
> @@ -80,47 +80,47 @@ _compare_range  $testdir/file1 $((blksz * 48 - 20)) \
>         || echo "End sections do not match (intentional)"
>  
>  echo "Compare the CoW'd section to the after file"
> -_compare_range $testdir/file2 0 $testdir/file3 0 17 \
> +_compare_range $testdir/file2 0 $testdir/file2.chk 0 17 \
>         || echo "Start sections do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 16 - 34)) \
> -		$testdir/file3 $((blksz * 16 - 34)) 17 \
> +		$testdir/file2.chk $((blksz * 16 - 34)) 17 \
>         || echo "Middle sections do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 48 - 20)) \
> -		$testdir/file3 $((blksz * 48 - 20)) 17 \
> +		$testdir/file2.chk $((blksz * 48 - 20)) 17 \
>         || echo "End sections do not match"
>  
>  echo "Compare the not CoW'd sections"
>  _compare_range $testdir/file1 18 $testdir/file2 18 17 \
> -       || echo "Start sections of 1-2 do not match"
> +       || echo "Start sections of file1 and file2 do not match"
>  
> -_compare_range $testdir/file2 18 $testdir/file3 18 17 \
> -       || echo "Start sections of 2-3 do not match"
> +_compare_range $testdir/file2 18 $testdir/file2.chk 18 17 \
> +       || echo "Start sections of file2 and file2.chk do not match"
>  
>  _compare_range  $testdir/file1 $((blksz * 16 - 17)) \
>  		$testdir/file2 $((blksz * 16 - 17)) 82 \
> -       || echo "Middle sections of 1-2 do not match"
> +       || echo "Middle sections of file1 and file2 do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 16 - 17)) \
> -		$testdir/file3 $((blksz * 16 - 17)) 82 \
> -       || echo "Middle sections of 2-3 do not match"
> +		$testdir/file2.chk $((blksz * 16 - 17)) 82 \
> +       || echo "Middle sections of file2 and file2.chk do not match"
>  
>  _compare_range  $testdir/file1 $((blksz * 48 - 120)) \
>  		$testdir/file2 $((blksz * 48 - 120)) 100 \
> -       || echo "End sections of 1-2 do not match"
> +       || echo "End sections of file1 and file2 do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 48 - 120)) \
> -		$testdir/file3 $((blksz * 48 - 120)) 100 \
> -       || echo "End sections of 2-3 do not match"
> +		$testdir/file2.chk $((blksz * 48 - 120)) 100 \
> +       || echo "End sections of file2 and file2.chk do not match"
>  
>  _compare_range  $testdir/file1 $((blksz * 14)) \
>  		$testdir/file2 $((blksz * 14)) $blksz \
> -       || echo "Untouched sections of 1-2 do not match"
> +       || echo "Untouched sections of file1 and file2 do not match"
>  
>  _compare_range  $testdir/file2 $((blksz * 14)) \
> -		$testdir/file3 $((blksz * 14)) $blksz \
> -       || echo "Untouched sections of 2-3 do not match"
> +		$testdir/file2.chk $((blksz * 14)) $blksz \
> +       || echo "Untouched sections of file2 and file2.chk do not match"
>  
>  # success, all done
>  status=0
> diff --git a/tests/generic/140.out b/tests/generic/140.out
> index 51a5b854..89389001 100644
> --- a/tests/generic/140.out
> +++ b/tests/generic/140.out
> @@ -3,14 +3,14 @@ Create the original files
>  Compare files
>  60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-140/file1
>  60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-140/file2
> -60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-140/file3
> +60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-140/file2.chk
>  mmap CoW the second file
>  Compare files
>  60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-140/file1
>  795ecfd281dbda4916431376228e4187  TEST_DIR/test-140/file2
> -795ecfd281dbda4916431376228e4187  TEST_DIR/test-140/file3
> -Files 1-2 do not match (intentional)
> -Files 1-3 do not match (intentional)
> +795ecfd281dbda4916431376228e4187  TEST_DIR/test-140/file2.chk
> +file1 and file2 do not match (intentional)
> +file1 and file2.chk do not match (intentional)
>  Compare the CoW'd section to the before file
>  Start sections do not match (intentional)
>  Middle sections do not match (intentional)
> -- 
> 2.33.0
> 
> 
> 
