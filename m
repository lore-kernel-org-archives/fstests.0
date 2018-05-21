Received: from mail-pg0-f68.google.com ([74.125.83.68]:42336 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeEUC34 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 May 2018 22:29:56 -0400
Received: by mail-pg0-f68.google.com with SMTP id p9-v6so5677051pgc.9
        for <fstests@vger.kernel.org>; Sun, 20 May 2018 19:29:56 -0700 (PDT)
Date: Mon, 21 May 2018 10:29:51 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic: fix cleanup function for test 490
Message-ID: <20180521022951.GI29080@desktop.hz.ali.com>
References: <20180520184517.8826-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180520184517.8826-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, jack@suse.cz
List-ID: <fstests@vger.kernel.org>

On Sun, May 20, 2018 at 02:45:17PM -0400, Theodore Ts'o wrote:
> generic/490 fails because cleanup tries to delete . and .. since $tmp
> is left unset, and so "rm -f $tmp.*" does nothing useful.  Instead
> delete temp files created by seek_sanity_test.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Sorry, this is my bad, Jan's original patch did just remove the
test files, I intended to use lower case variable name but did wrong
update in _cleanup(). Thanks for the fix!

Eryu
> ---
>  tests/generic/490 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/490 b/tests/generic/490
> index b5042c2e..c0335ca0 100755
> --- a/tests/generic/490
> +++ b/tests/generic/490
> @@ -49,7 +49,7 @@ _require_test_program "seek_sanity_test"
>  _cleanup()
>  {
>  	cd /
> -	rm -f $tmp.*
> +	rm -f $base_test_file*
>  }
>  
>  $here/src/seek_sanity_test -s 19 -e 20 $base_test_file > $seqres.full 2>&1 ||
> -- 
> 2.16.1.72.g5be1f00a9a
> 
