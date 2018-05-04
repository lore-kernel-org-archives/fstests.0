Received: from mail-pg0-f68.google.com ([74.125.83.68]:35971 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDO62 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 May 2018 10:58:28 -0400
Received: by mail-pg0-f68.google.com with SMTP id z129-v6so11447566pgz.3
        for <fstests@vger.kernel.org>; Fri, 04 May 2018 07:58:27 -0700 (PDT)
Date: Fri, 4 May 2018 22:58:22 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] check: run auto test group by default
Message-ID: <20180504145822.GC8373@desktop>
References: <20180504000509.2498-1-david@fromorbit.com>
 <20180504035039.GC4116@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504035039.GC4116@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, willy@infradead.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 03, 2018 at 08:50:39PM -0700, Darrick J. Wong wrote:
> On Fri, May 04, 2018 at 10:05:09AM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Everyone who starts using fstests runs "check" without parameters,
> > and then has problems with it running dangerous tests. most people
> > just want fstests to act as a regression test suite, not a fuzzer or
> > exercise known crash conditions. Hence make the default behaviour to
> > be "run the auto group" rather than "run every test".
> > 
> > To enable people to run all tests easily (if they really want to)
> > add a special group keyword named "all". This wildcard will trigger
> > selecting all the tests in fstests as per the original "check
> > without parameters" behaviour.
> > 
> > Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> > ---
> >  check | 34 +++++++++++++++++++++-------------
> >  1 file changed, 21 insertions(+), 13 deletions(-)
> > 
> > diff --git a/check b/check
> > index 84a35e6724ab..170004d4b2a2 100755
> > --- a/check
> > +++ b/check
> > @@ -102,6 +102,8 @@ a test file name match pattern (e.g. xfs/*).
> >  group argument is either a name of a tests group to collect from all
> >  the test dirs (e.g. quick) or a name of a tests group to collect from
> >  a specific tests dir in the form of <test dir>/<group name> (e.g. xfs/quick).
> > +If you want to run all the tests in teh test suite, use "-g all" to specify all
> 
> ...the test suite... (unless you really mean the rock band :P)

Fixed on commit.

> 
> Looks ok otherwise,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks.

Eryu

> 
> --D
> 
> > +groups.
> >  
> >  exclude_file argument refers to a name of a file inside each test directory.
> >  for every test dir where this file is found, the listed test names are
> > @@ -220,22 +222,24 @@ _prepare_test_list()
> >  	fi
> >  
> >  	# Specified groups to include
> > -	for group in $GROUP_LIST; do
> > -		list=$(get_group_list $group)
> > -		if [ -z "$list" ]; then
> > -			echo "Group \"$group\" is empty or not defined?"
> > -			exit 1
> > -		fi
> > +	# Note that the CLI processing adds a leading space to the first group
> > +	# parameter, so we have to catch that here checking for "all"
> > +	if ! $have_test_arg && [ "$GROUP_LIST" == " all" ]; then
> > +		# no test numbers, do everything
> > +		get_all_tests
> > +	else
> > +		for group in $GROUP_LIST; do
> > +			list=$(get_group_list $group)
> > +			if [ -z "$list" ]; then
> > +				echo "Group \"$group\" is empty or not defined?"
> > +				exit 1
> > +			fi
> >  
> > -		for t in $list; do
> > -			grep -s "^$t\$" $tmp.list >/dev/null || \
> > +			for t in $list; do
> > +				grep -s "^$t\$" $tmp.list >/dev/null || \
> >  							echo "$t" >>$tmp.list
> > +			done
> >  		done
> > -	done
> > -
> > -	if ! $have_test_arg && [ -z "$GROUP_LIST" ]; then
> > -		# no test numbers, do everything
> > -		get_all_tests
> >  	fi
> >  
> >  	# Specified groups to exclude
> > @@ -364,6 +368,10 @@ if $have_test_arg; then
> >  
> >  		shift
> >  	done
> > +elif [ -z "$GROUP_LIST" ]; then
> > +	# default group list is the auto group. If any other group or test is
> > +	# specified, we use that instead.
> > +	GROUP_LIST="auto"
> >  fi
> >  
> >  # we need common/rc
> > -- 
> > 2.17.0
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
