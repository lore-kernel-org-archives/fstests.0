Received: from mail-pl0-f54.google.com ([209.85.160.54]:43830 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeBZKKq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Feb 2018 05:10:46 -0500
Received: by mail-pl0-f54.google.com with SMTP id f23so8992449plr.10
        for <fstests@vger.kernel.org>; Mon, 26 Feb 2018 02:10:46 -0800 (PST)
Date: Mon, 26 Feb 2018 18:10:33 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] check: fail tests if check/dmesg are not clean
Message-ID: <20180226101033.GA3767@localhost.localdomain>
References: <20180223011632.28893-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223011632.28893-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Dave,

On Fri, Feb 23, 2018 at 12:16:32PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Currently a test passes even if it leaves a corrupt filesystem
> behind, or a splat in the system logs that should not be there.
> Rework the check code to consider these as test failures so they can
> be accounted and tracked correctly. This also allows us to include
> the post-test filesystem checking in the test runtime - that is
> currently not accounted to the test, either, so the real runtime of
> each test is not accurately reflected in the time stats being
> reported.
> 
> This requires a complete reworking of the main test check loop. It's
> a bunch of spaghetti at the moment because it has post test
> reporting code preventing use from using continue when a test is
> done. Move that post test reporting to the start of the next loop
> iteration and clean up the code to use continues where appropriate.
> 
> Also, for cases where we haven't run the test or it's already been
> marked as failed, don't bother running the filesystem/dmesg checks
> for failure as we're already going to report the test as failed.
> 
> This touches almost all of the loop, so get rid of the remaining
> 4 space indents inside the loop while moving all this code around.
> 
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> ---
>  check | 250 +++++++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 132 insertions(+), 118 deletions(-)
> 

[snip]

> @@ -724,90 +742,86 @@ for section in $HOST_OPTIONS_SECTIONS; do

Patch doesn't apply starting from this hunk.

Applying: check: fail tests if check/dmesg are not clean
error: patch failed: check:724

>  			./$seq >$tmp.out 2>&1

This context doesn't look right, it should be

			./$seq >$tmp.rawout 2>&1

>  			sts=$?
>  		fi
> -		$timestamp && _timestamp
> -		stop=`_wallclock`

And there're two more lines below the two removed lines:

                _fix_malloc <$tmp.rawout >$tmp.out                                                                                                                                             
                rm -f $tmp.rawout

And the code has been this way since 2015, so it's not likely some
random conflicts caused by recent patches.

$ git blame -L 724,734 check
7fd308513c0ae (Jan Tulak       2015-08-04 14:10:49 +1000 724)                   ./$seq >$tmp.rawout 2>&1
7fd308513c0ae (Jan Tulak       2015-08-04 14:10:49 +1000 725)                   sts=$?
7fd308513c0ae (Jan Tulak       2015-08-04 14:10:49 +1000 726)           fi
bf4445942d2ba (Lukas Czerner   2014-04-04 17:17:53 +1100 727)           $timestamp && _timestamp
bf4445942d2ba (Lukas Czerner   2014-04-04 17:17:53 +1100 728)           stop=`_wallclock`
774f4dd775340 (Tomas Racek     2013-09-19 16:20:37 +0000 729) 
bf4445942d2ba (Lukas Czerner   2014-04-04 17:17:53 +1100 730)           _fix_malloc <$tmp.rawout >$tmp.out
bf4445942d2ba (Lukas Czerner   2014-04-04 17:17:53 +1100 731)           rm -f $tmp.rawout
bf4445942d2ba (Lukas Czerner   2014-04-04 17:17:53 +1100 732) 
bf4445942d2ba (Lukas Czerner   2014-04-04 17:17:53 +1100 733)           if [ -f core ]
bf4445942d2ba (Lukas Czerner   2014-04-04 17:17:53 +1100 734)           then

Do you have some local patches applied?

Thanks,
Eryu
