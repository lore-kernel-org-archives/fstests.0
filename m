Received: from mx1.redhat.com ([209.132.183.28]:44306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfIDGrX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Sep 2019 02:47:23 -0400
Date: Wed, 4 Sep 2019 14:54:23 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/430: add copy in same file test
Message-ID: <20190904065423.GY7239@dhcp-12-102.nay.redhat.com>
References: <20190904053246.19623-1-yin-jianhong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904053246.19623-1-yin-jianhong@163.com>
Sender: fstests-owner@vger.kernel.org
To: "Jianhong.Yin" <yin-jianhong@163.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 04, 2019 at 01:32:46PM +0800, Jianhong.Yin wrote:
> to cover this bug:
>  copy_file_range return "Invalid argument" when copy in the same file
>  https://bugzilla.kernel.org/show_bug.cgi?id=202935
> 
> this is a base function test, I don't think we should add a new
> test for it like 553 554, so add it in generic/430
> what do you think?

Personal question shouldn't be in commit log. You just need to describe
what your patch does.

> 
> Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
> ---

Personal question can be written at here.

>  tests/generic/430     | 7 +++++++
>  tests/generic/430.out | 4 ++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/tests/generic/430 b/tests/generic/430
> index 1b11f60d..c4b1dd23 100755
> --- a/tests/generic/430
> +++ b/tests/generic/430
> @@ -6,6 +6,7 @@
>  #
>  # Tests vfs_copy_file_range():
>  #   - Copy a file
> +#   - Copy in same file
>  #   - Copy beginning of original to new file
>  #   - Copy middle of original to a new file
>  #   - Copy end of original to new file
> @@ -52,6 +53,12 @@ cmp $testdir/file $testdir/copy
>  echo "Original md5sums:"
>  md5sum $testdir/{file,copy} | _filter_test_dir
>  
> +echo "Copy in same file"
> +$XFS_IO_PROG    -c "copy_range -l 1000 $testdir/copy" "$testdir/copy"

I prefer trying to copy whole 5000 bytes data at here, but I can't say
why not '1000', so it's up to you :)

And maybe you can explain why '-l XXXX' is necessary at here, for example
to avoid the target file be truncated to 0 by copy_range.

> +cmp $testdir/file $testdir/copy
> +echo "Original md5sums:"
> +md5sum $testdir/{file,copy} | _filter_test_dir

You didn't change $testdir/file, so maybe you just need to check the
$testdir/copy checksum at here?

Thanks,
Zorro

> +
>  echo "Copy beginning of original file"
>  $XFS_IO_PROG -f -c "copy_range -l 1000 $testdir/file" "$testdir/beginning"
>  cmp -n 1000 $testdir/file $testdir/beginning
> diff --git a/tests/generic/430.out b/tests/generic/430.out
> index 4b4ca75d..95007853 100644
> --- a/tests/generic/430.out
> +++ b/tests/generic/430.out
> @@ -3,6 +3,10 @@ Create the original file and then copy
>  Original md5sums:
>  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
>  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
> +Create in same file
> +Original md5sums:
> +e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
> +e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
>  Copy beginning of original file
>  md5sums after copying beginning:
>  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
> -- 
> 2.17.2
> 
