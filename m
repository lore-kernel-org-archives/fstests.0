Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07A7EB64DC
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Jul 2023 15:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGCPpB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Jul 2023 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCPpA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Jul 2023 11:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606FE5A
        for <fstests@vger.kernel.org>; Mon,  3 Jul 2023 08:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD2D360FB2
        for <fstests@vger.kernel.org>; Mon,  3 Jul 2023 15:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CC1C433C7;
        Mon,  3 Jul 2023 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688399098;
        bh=nqWnJSQE48LbtTD9vCyK/85NQUiMIje7rPO7FWgos8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kVU/bDrkUXItoDGgqlJrc8itsJOHTmcEdlFTsjuzZjRRPJvOqXlIAuoyNzbsCdX0L
         bDZfP8dy18+NtBN4VWKrLcvsUysr0sjdk9mCAKY91P33oBYz4nMF53av6LUiCidvrl
         AwgbEkGhSa6GYL78K1gJc4cb++dNMyPPqrO2D/vLOCHxZWH0M2yrGhGtvAGjL6XlCH
         gSsnPqAqk5yoIDCmILW5+Qt7Lsl8Wj56Nxoo/lr7v1vC37TBsj+B5uoYkPXF/5MRMv
         JmlZDTiwslWe+muEg08ey12z4Ug54jrBiLX69Air42C3FhrTH/wXaKbNvvoQDKcofy
         3yURmZDn/6ZYQ==
Date:   Mon, 3 Jul 2023 08:44:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     yuezhang.mo@foxmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH] check: fix excluded tests are only expunged in the first
 iteration
Message-ID: <20230703154457.GD11427@frogsfrogsfrogs>
References: <tencent_02888B6E2AB95F44BA9CB8A5408E86CE2906@qq.com>
 <20230703145120.evwr45jftcd6wl62@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703145120.evwr45jftcd6wl62@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 03, 2023 at 10:51:20PM +0800, Zorro Lang wrote:
> On Fri, Jun 30, 2023 at 08:28:29PM +0800, yuezhang.mo@foxmail.com wrote:
> > From: Yuezhang Mo <yuezhang.mo@foxmail.com>
> > 
> > If iterating more than once and excluding some tests, the
> > excluded tests are expunged in the first iteration, but run in
> > subsequent iterations. This is not expected.
> 
> Can you provide an example about how to reproduce the issue you metioned above.
> 
> > 
> > The problem was caused by the temporary file saving the excluded
> > tests being deleted at the end of the first iteration.
> > 
> > This commit saves the excluded tests into a variable instead of a
> > temp file.
> > 
> > Signed-off-by: Yuezhang Mo <yuezhang.mo@foxmail.com>
> > ---
> >  check | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/check b/check
> > index e36978c1..a8071121 100755
> > --- a/check
> > +++ b/check
> > @@ -27,6 +27,7 @@ DUMP_OUTPUT=false
> >  iterations=1
> >  istop=false
> >  loop_on_fail=0
> > +exclude_tests=()
> >  
> >  # This is a global variable used to pass test failure text to reporting gunk
> >  _err_msg=""
> > @@ -46,7 +47,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
> >  # by default don't output timestamps
> >  timestamp=${TIMESTAMP:=false}
> >  
> > -rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
> > +rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
> >  
> >  SRC_GROUPS="generic shared"
> >  export SRC_DIR="tests"
> > @@ -302,13 +303,13 @@ while [ $# -gt 0 ]; do
> >  		;;
> >  	-e)
> >  		xfile=$2; shift ;
> > -		echo "$xfile" | tr ', ' '\n\n' >> $tmp.xlist
> > +		exclude_tests+=($(echo "$xfile" | tr ', ' '\n\n'))
> 
> If print to a file, I don't mind above way. But if to an array, how about:
> 
>   read -a tmpxlist < <(echo "$xfile" | tr ',' ' ')
>   exclude_tests+=(${tmpxlist[@]})

readarray -t -O "${#exclude_tests[@]}" exclude_tests < <(echo "$xfile" | tr ',' ' '))

> >  		;;
> >  
> >  	-E)	xfile=$2; shift ;
> >  		if [ -f $xfile ]; then
> > -			sed "s/#.*$//" "$xfile" >> $tmp.xlist
> > -	        fi
> > +			exclude_tests+=($(sed "s/#.*$//" "$xfile"))
> > +		fi
> 
> Similar as above, how about:
> 
>   readarray tmpxlist < <(sed "s/#.*$//" $xfile)
>   exclude_tests+=(${tmpxlist[@]})
> 
> Feel free to provide better methods if anyone has.
> 
> >  		;;
> >  	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
> >  	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
> > @@ -383,7 +384,7 @@ if [ -n "$subdir_xfile" ]; then
> >  	for d in $SRC_GROUPS $FSTYP; do
> >  		[ -f $SRC_DIR/$d/$subdir_xfile ] || continue
> >  		for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
> > -			echo $d/$f >> $tmp.xlist
> > +			exclude_tests+=($d/$f)
> >  		done
> >  	done
> >  fi
> > @@ -570,11 +571,10 @@ _check_filesystems()
> >  _expunge_test()
> >  {
> >  	local TEST_ID="$1"
> > -	if [ -s $tmp.xlist ]; then
> > -		if grep -q $TEST_ID $tmp.xlist; then
> > -			echo "       [expunged]"
> > -			return 1
> > -		fi
> > +
> > +	if echo ${exclude_tests[*]} | grep -q $TEST_ID; then
> 
> How about using the "-w" option to grep. Due to the number of fstests' cases
> will out of 999 (I'm thinking about how to deal with it), we might have
> generic/1000 in one day.

Four digit ids work fine; I've had xfs/12xx and xfs/15xx in djwong-dev
for years now with no problems.

> If so "grep generic/100" will match generic/1000 and
> generic/100 both.

Yeah, that grep string ought to be grep -q "^$TEST_ID$" or something.

Or

is_excluded() {
	for f in "${exclude_tests[@]}"; do
		[[ "$f" == "$1" ]] && return 0
	done
	return 1
}

(Though saving the overhead of one fork/exec is probably minimal.)

	if is_excluded "$TEST_ID"; then ...

--D

> Thanks,
> Zorro
> 
> > +		echo "       [expunged]"
> > +		return 1
> >  	fi
> >  	return 0
> >  }
> > -- 
> > 2.25.1
> > 
> 
