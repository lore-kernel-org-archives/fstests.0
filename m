Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C42C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  6 May 2022 07:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389435AbiEFHRL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 May 2022 03:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiEFHRG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 May 2022 03:17:06 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0746A66F9E
        for <fstests@vger.kernel.org>; Fri,  6 May 2022 00:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651821200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FWQdOPzv40LVTUPwaBAHdQoheWGpMltNB4jG03Kkdp8=;
        b=IkoMVGaye8uLiMnMQqJoci9X3wY3s/a39Vz8KjLtq/+PDSRASF0CIVFuXXNXUR/LXwmnCv
        js/Hi0nDLtFhTWXJfRjIzHolL11nnCOIAC9dcbZybU1LmN9TcJZdgv7qm8jfYX0DZyOv0/
        y4vyXz1dvlw4DTM2V0koApoeVBqiQYU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-qmFO2ltzOR-eJuBddoIngw-1; Fri, 06 May 2022 03:13:19 -0400
X-MC-Unique: qmFO2ltzOR-eJuBddoIngw-1
Received: by mail-qt1-f199.google.com with SMTP id g1-20020ac85801000000b002f3b281f745so5364551qtg.22
        for <fstests@vger.kernel.org>; Fri, 06 May 2022 00:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=FWQdOPzv40LVTUPwaBAHdQoheWGpMltNB4jG03Kkdp8=;
        b=bujD6NlKpCIn3bcgZ0oqSoTymbMq/6IdfU4a2TeC0yyhV3SuhScC18Q50JGd3uhhRi
         ld7GrJ2N6YBhLaO4ktyy7dGOQWSmU2TIxI832rHtBT6rftzOql38WmAyRM//VGGl/K26
         KUdx0e92lxuOiwe2XFF1FCGLcSDwNqDzLiRIsLqlTW3sWUTtz8OcBZSdCBWSah2Xyhe0
         CfSPZJIK/K6kLMGZT3vF6b+FK9aYRzvnFwL/BMpMkXMNqPs71RKoxD3xQy0lSjwVB6qb
         pKdpFdjYNkJXe1+olwgN577JxzY3zVRTPBtkM9DhVVbTVVoLpxVLb/Rb84nS0WAUrPWc
         jHjQ==
X-Gm-Message-State: AOAM533EUGkDIqkOiMjlOyBD/fDrAUw3xlXBu31lLOOKXp+wz95TcMFc
        d+dv5GkwqsT/ibHj/M3VPDezO3hBWYRhKywXIfTrMUXODIL/Hb669pMDPK2lNOC2gFPp+yzDy3Y
        9btIx+ejd1lnftsfBLQ==
X-Received: by 2002:a05:620a:170f:b0:6a0:41dc:8f6c with SMTP id az15-20020a05620a170f00b006a041dc8f6cmr1436789qkb.191.1651821198130;
        Fri, 06 May 2022 00:13:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza/FCwdpgrVWa4tAUYnQUBGviPvRgQORsN+S93MopbRCZx4hCbdHSCeq8aTIvVbOB0PQzskw==
X-Received: by 2002:a05:620a:170f:b0:6a0:41dc:8f6c with SMTP id az15-20020a05620a170f00b006a041dc8f6cmr1436751qkb.191.1651821196809;
        Fri, 06 May 2022 00:13:16 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d16-20020ac86150000000b002f39b99f6a5sm2259983qtm.63.2022.05.06.00.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 00:13:16 -0700 (PDT)
Date:   Fri, 6 May 2022 15:13:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: faster group file creation
Message-ID: <20220506071311.uhdgdzl26zajdclm@zlang-mailbox>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        fstests@vger.kernel.org
References: <20220506031232.483883-1-david@fromorbit.com>
 <20220506051017.GF1949718@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506051017.GF1949718@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 06, 2022 at 03:10:17PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> We don't need to execute every test just to check it's groups are
> valid. Just grab all the groups with grep, pull out the unique ones,
> then check them.
> 
> This also avoids the problem of editor swap files being present in
> the test directory and breaking the build because they are not
> executable.
> 
> Building on a clean, already built tree so it only builds the
> group lists:
> 
> $ time make
> ....
> Building udf
>  [GROUP] /home/dave/src/xfstests-dev/tests/udf/group.list
> Building xfs
>  [GROUP] /home/dave/src/xfstests-dev/tests/xfs/group.list
> 
> real    0m36.917s
> user    0m15.032s
> sys     0m26.219s
> $
> 
> Patched:
> 
> $ time make
> ....
> Building udf
>  [GROUP] /home/dave/src/xfstests-dev/tests/udf/group.list
> Building xfs
>  [GROUP] /home/dave/src/xfstests-dev/tests/xfs/group.list
> groups "frobnozzle" not mentioned in documentation.
> gmake[3]: *** [../../include/buildgrouplist:8: group.list] Error 1
> gmake[2]: *** [../include/buildrules:31: xfs] Error 2
> gmake[1]: *** [include/buildrules:31: tests] Error 2
> make: *** [Makefile:51: default] Error 2
> 
> real    0m1.751s
> user    0m0.863s
> sys     0m1.067s
> 
> $
> 
> Just a little bit faster, and as you can see that it still detects
> groups that are not documented. There was also an open .001.swp file
> in the XFS directory and that doesn't throw a failure anymore,
> either.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Looks good to me. It's much faster than before, especially when rebuild for
small changes.

Reviewed-by: Zorro Lang <zlang@kernel.org>

> V2: don't optimise away the per-test group listing in the output
> file that check relies on for '-g <group>' matching.
> 
>  common/preamble   | 28 -----------------------
>  tools/mkgroupfile | 66 ++++++++++++++++++++++++++++++++++++++-----------------
>  2 files changed, 46 insertions(+), 48 deletions(-)
> 
> diff --git a/common/preamble b/common/preamble
> index 64d79385..f4a405ac 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -23,26 +23,6 @@ _register_cleanup()
>  	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
>  }
>  
> -# Make sure each group is in the documentation file.
> -_check_groups() {
> -	test -n "$GROUPNAME_DOC_FILE" || return 0
> -
> -	local testname="$(echo "$0" | sed -e 's/^.*tests\///g')"
> -	declare -a missing=()
> -
> -	for group in "$@"; do
> -		if ! grep -q "^${group}[[:space:]]" "$GROUPNAME_DOC_FILE"; then
> -			missing+=("\"${group}\"")
> -		fi
> -	done
> -	test "${#missing}" -eq 0 && return 0
> -
> -	local suffix=
> -	test "${#missing}" -gt 1 && suffix="s"
> -	echo "$testname: group$suffix ${missing[@]} not mentioned in documentation." 1>&2
> -	return 1
> -}
> -
>  # Prepare to run a fstest by initializing the required global variables to
>  # their defaults, sourcing common functions, registering a cleanup function,
>  # and removing the $seqres.full file.
> @@ -59,14 +39,6 @@ _begin_fstest()
>  
>  	seq=`basename $0`
>  
> -	# If we're only running the test to generate a group.list file,
> -	# spit out the group data and exit.
> -	if [ -n "$GENERATE_GROUPS" ]; then
> -		_check_groups "$@" || exit 1
> -		echo "$seq $@"
> -		exit 0
> -	fi
> -
>  	seqres=$RESULT_DIR/$seq
>  	echo "QA output created by $seq"
>  
> diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> index 3844e57d..24435898 100755
> --- a/tools/mkgroupfile
> +++ b/tools/mkgroupfile
> @@ -11,40 +11,64 @@ fi
>  
>  test_dir="$PWD"
>  groupfile="$1"
> +new_groups="/tmp/groups.$$"
>  GROUPNAME_DOC_FILE="$(readlink -m ../../doc/group-names.txt)"
> -export GROUPNAME_DOC_FILE
>  
>  if [ ! -x ../../check ]; then
>  	echo "$0: Run this from tests/XXX/."
>  	exit 1
>  fi
>  
> -cleanup() {
> -	test -z "$groupfile" && return
> -	test -z "$ngroupfile" && return
> -
> -	if [ $ret -eq 0 ]; then
> -		mv -f "$ngroupfile" "$groupfile"
> -	else
> -		rm -f "$ngroupfile"
> -	fi
> +cleanup()
> +{
> +	rm -f $new_groups.check
> +	rm -f $new_groups
>  }
>  
>  ret=1	# trigger cleanup of temporary files unless we succeed
>  trap 'cleanup; exit $ret' EXIT INT TERM QUIT
>  
> +# Make sure each group is in the documentation file.
> +_check_groups() {
> +	test -n "$GROUPNAME_DOC_FILE" || return 0
> +
> +	local groups="$1"
> +	declare -a missing=()
> +
> +	for group in `grep -v '#' $groups`; do
> +		if ! grep -q "^${group}[[:space:]]" "$GROUPNAME_DOC_FILE"; then
> +			missing+=("\"${group}\"")
> +		fi
> +	done
> +	test "${#missing}" -eq 0 && return 0
> +
> +	local suffix=
> +	test "${#missing}" -gt 1 && suffix="s"
> +	echo "group$suffix ${missing[@]} not mentioned in documentation." 1>&2
> +	ret=1
> +	exit 1
> +}
> +
>  generate_groupfile() {
> -	cat << ENDL
> +	cat << ENDL > $new_groups
>  # QA groups control file, automatically generated.
>  # See _begin_fstest in each test for details.
>  
>  ENDL
> +
>  	cd ../../
> -	export GENERATE_GROUPS=yes
> -	grep -R -l "^_begin_fstest" "$test_dir/" 2>/dev/null | while read testfile; do
> -		test -x "$testfile" && "$testfile" || return 1
> -	done | sort -g
> -	ret="${PIPESTATUS[1]}"
> +
> +	# Aggregate the groups each test belongs to for the group file
> +	grep -I -R "^_begin_fstest" $test_dir/ | \
> +		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> +
> +	# Create the list of unique groups for existence checking
> +	grep -I -R "^_begin_fstest" $test_dir/ | \
> +		sed -e 's/^.*_begin_fstest //' -e 's/ /\n/g' | \
> +		sort -u > $new_groups.check
> +
> +	_check_groups $new_groups.check
> +
>  	cd "$test_dir"
>  }
>  
> @@ -52,10 +76,12 @@ if [ -z "$groupfile" ] || [ "$groupfile" = "-" ]; then
>  	# Dump the group file to stdout and exit
>  	unset groupfile
>  	generate_groupfile
> +	cat $new_groups
>  else
>  	# Otherwise, write the group file to disk somewhere.
> -	ngroupfile="${groupfile}.new"
> -	rm -f "$ngroupfile"
> -	generate_groupfile >> "$ngroupfile"
> -	# let cleanup rename or delete ngroupfile
> +	generate_groupfile
> +	mv -f "$new_groups" "$groupfile"
>  fi
> +
> +# Success!
> +ret=0
> 

