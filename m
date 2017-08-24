Received: from mx1.redhat.com ([209.132.183.28]:37336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbdHXRkq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 24 Aug 2017 13:40:46 -0400
Date: Fri, 25 Aug 2017 01:40:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] check: print elapsed time even for failed tests
Message-ID: <20170824174044.GO31418@eguan.usersys.redhat.com>
References: <20170824131557.32342-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170824131557.32342-1-dsterba@suse.com>
Sender: fstests-owner@vger.kernel.org
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 24, 2017 at 03:15:57PM +0200, David Sterba wrote:
> Sometimes it's useful to see how long the test runs.  The time is
> calculated the same way as in the normal case but the time is not stored
> in the $tmp.time file.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index f8db3cd6dfab..f3a1b72e4b2b 100755
> --- a/check
> +++ b/check
> @@ -755,7 +755,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  			    fi
>  			    echo ""
>  			else
> -			    echo " - output mismatch (see $seqres.out.bad)"
> +			    echo " `expr $stop - $start`s - output mismatch (see $seqres.out.bad)"

This only prints out test time in the output mismatch case, there's
another 'exit with nonzero' failure case needs the test time too.

I did the following updates based on your patch and it worked for me for
both failure cases, can you please take a look and verify too? I can
fold this update to your patch if it looks fine to you.

---
diff --git a/check b/check
index f3a1b72..7763389 100755
--- a/check
+++ b/check
@@ -729,18 +729,12 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		    n_notrun=`expr $n_notrun + 1`
 		    tc_status="notrun"
 		else
-		    if [ $sts -ne 0 ]
-		    then
-			err_msg="[failed, exit status $sts]"
-			echo -n " $err_msg"
-			err=true
-		    fi
 		    if [ ! -f $seq.out ]
 		    then
 			_dump_err "no qualified output"
 			err=true
 		    else
-
+			testtime=`expr $stop - $start`
 			# coreutils 8.16+ changed quote formats in error messages from
 			# `foo' to 'foo'. Filter old versions to match the new version.
 			sed -i "s/\`/\'/g" $tmp.out
@@ -750,12 +744,19 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			    then
 				:
 			    else
-				echo "$seqnum `expr $stop - $start`" >>$tmp.time
-				echo -n " `expr $stop - $start`s"
+				if [ $sts -ne 0 ]
+				then
+				    err_msg="[failed, exit status $sts]"
+				    echo -n " ${testtime}s $err_msg"
+				    err=true
+				else
+				    echo "$seqnum $testtime" >>$tmp.time
+				    echo -n " ${testtime}s"
+				fi
 			    fi
 			    echo ""
 			else
-			    echo " `expr $stop - $start`s - output mismatch (see $seqres.out.bad)"
+			    echo " ${testtime}s - output mismatch (see $seqres.out.bad)"
 			    mv $tmp.out $seqres.out.bad
 			    $diff $seq.out $seqres.out.bad | {
 				if test "$DIFF_LENGTH" -le 0; then
---

Thanks,
Eryu
