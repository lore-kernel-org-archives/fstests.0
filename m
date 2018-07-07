Received: from mail-pl0-f68.google.com ([209.85.160.68]:40762 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753358AbeGGLZF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 Jul 2018 07:25:05 -0400
Received: by mail-pl0-f68.google.com with SMTP id t6-v6so3998290plo.7
        for <fstests@vger.kernel.org>; Sat, 07 Jul 2018 04:25:05 -0700 (PDT)
Date: Sat, 7 Jul 2018 19:25:00 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 6/8] ext4: convert some tests to new setup preamble
Message-ID: <20180707112500.GG2780@desktop>
References: <20180627082103.9662-1-david@fromorbit.com>
 <20180627082103.9662-7-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627082103.9662-7-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 06:21:01PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Small initial batch to demonstrate conversion.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/ext4/001 | 26 +++++++-------------------
>  tests/ext4/002 | 41 +++++++++++++----------------------------
>  tests/ext4/003 | 25 +++++++------------------
>  tests/ext4/004 | 46 ++++++++++++++++------------------------------
>  tests/ext4/005 | 29 +++++++----------------------
>  tests/ext4/006 | 38 +++++++++++++-------------------------
>  tests/ext4/007 | 34 ++++++++++------------------------
>  tests/ext4/008 | 28 +++++++---------------------
>  tests/ext4/009 | 34 ++++++++++------------------------
>  9 files changed, 90 insertions(+), 211 deletions(-)
> 
> diff --git a/tests/ext4/001 b/tests/ext4/001
> index bf2d16b42b3c..deba9128d833 100755
> --- a/tests/ext4/001
> +++ b/tests/ext4/001
> @@ -6,28 +6,16 @@
>  #
>  # Test fallocate FALLOC_FL_ZERO_RANGE
>  #
> -seqfull=$0

This is needed and used by _link_out_file_named(), without defining it
test is unable to find .cfg file to do the .out file link.

How about making "seqfull" part of the test setup preamble?

Thanks,
Eryu
