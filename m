Received: from mail-pl1-f193.google.com ([209.85.214.193]:35074 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1W3k (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Oct 2018 18:29:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id n4-v6so1979240plp.2
        for <fstests@vger.kernel.org>; Sun, 28 Oct 2018 06:44:59 -0700 (PDT)
Date: Sun, 28 Oct 2018 21:44:52 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] check: skip parsing if the file is not shell script.
Message-ID: <20181028134452.GE3876@desktop>
References: <20181024143307.25372-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024143307.25372-1-msys.mizuma@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: fstests@vger.kernel.org, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 24, 2018 at 10:33:07AM -0400, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> If we run tests using '*', for example './check xfs/*', we will
> get following error messages. This patch introduces to avoid
> the messages.
> 
> ./check xfs/*
> xfs/001.out - unknown test, ignored
> xfs/002.out - unknown test, ignored
> xfs/003.out - unknown test, ignored
> xfs/004.out - unknown test, ignored
> ...

Hmm, that's just not the recommended way to run tests. Not all tests are
valid (yes, there're broken tests) and sometimes we may forget to add x
permission on a test (though I have a local script to catch that, but it
did happen before).

Please either use a more precise pattern to match the tests you want to
run, or even better, run tests by specifying the groups, e.g.

./check -g xfs/log

to run all tests in 'log' group in 'xfs' directory.

Thanks,
Eryu

> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  check | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/check b/check
> index f3c8021d..96cb222f 100755
> --- a/check
> +++ b/check
> @@ -339,6 +339,10 @@ if $have_test_arg; then
>  				test_dir=`dirname $t`
>  				test_dir=${test_dir#$SRC_DIR/*}
>  				test_name=`basename $t`
> +				if ! file -bi $SRC_DIR/$test_dir/$test_name | \
> +					egrep -q 'text/x-shellscript'; then
> +					continue
> +				fi
>  				group_file=$SRC_DIR/$test_dir/group
>  
>  				if egrep -q "^$test_name" $group_file; then
> -- 
> 2.18.0
> 
