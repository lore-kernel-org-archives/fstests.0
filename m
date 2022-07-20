Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224CFC43334
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Jul 2022 18:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiGTSfv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGTSfu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 14:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542041081
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 11:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E44CD61941
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 18:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B25C3411E;
        Wed, 20 Jul 2022 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658342148;
        bh=3QUzURbbS9ymXJKmi26GI1z+zHnQeUi4uu0Gs0yrFng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKyFgCVhB5k3h9pDtFoWQxZ2yoHQc0CyayqlNG1ne1qjUAt6NlrajfOmA0OUmV1Sx
         g6yzt9Q0hhsdPLP1y+wf4DDGIAwhVMdwzNW+tl+djOKu4CrIgAP156x35VwqpFtqM1
         KWCHRpbSunWfswYCLZn2YmtDfgxC358nuC8OFEFrGPRUrlwHK+dxwnKMY0BmjDXvBB
         fRETz7vJ/Q+b+35kPIRHwLaz9GHrzOZ3HqNGQri+TlZzkkFSZWJt+Kk3QkxAtTrqNv
         qLaFSdyObEhixMGphqnMoeLYjYsjNu9LG0tVHWpvlX2LcuhNGHwMAiydIIxPzseDZi
         ku9/TRozLUz0Q==
Date:   Wed, 20 Jul 2022 11:35:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 1/4] report: add support for the xunit-quiet format
Message-ID: <YthLAxrK4QnPNQ6K@magnolia>
References: <20220720164356.4078789-1-tytso@mit.edu>
 <20220720164356.4078789-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720164356.4078789-2-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 20, 2022 at 12:43:53PM -0400, Theodore Ts'o wrote:
> The xunit-quiet format excludes the NNN.{full,dmesg,bad} files in
> <system-out> and <system-err> nodes which are included in the xunit
> report format.
> 
> For test runners that save the entire results directory to preserve
> all of the test artifacts, capturing the NNN.{full,dmesg,bad} in the
> results.xml file is redundant.  In addition, if the NNN.bad is too
> large, it can cause the junitparser python library to refuse to parse
> the XML file to prevent potential denial of service attacks[1].  A
> simple way to avoid this problem is to simply to omit the <system-out>
> and <system-err> nodes in the results.xml file.
> 
> [1] https://gitlab.com/gitlab-org/gitlab/-/issues/268035
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: David Disseldorp <ddiss@suse.de>

Looks fine to me, though I wonder if we should document what these
report formats actually do?

I really dislike the "xunit" name since AFAICT it's really the junit xml
format, not the xunit xml format, and this trips me up **every** single
time I have to go look at the fstests reporting code.

For this bit though,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  check         |  2 +-
>  common/report | 21 ++++++++++++++-------
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/check b/check
> index 5f6d86b4..0b2f10ed 100755
> --- a/check
> +++ b/check
> @@ -75,7 +75,7 @@ check options
>      -I <n>		iterate the test list <n> times, but stops iterating further in case of any test failure
>      -d			dump test output to stdout
>      -b			brief test summary
> -    -R fmt[,fmt]	generate report in formats specified. Supported format: [xunit]
> +    -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
>      --large-fs		optimise scratch device for large filesystems
>      -s section		run only specified section from config file
>      -S section		exclude the specified section from the config file
> diff --git a/common/report b/common/report
> index 5ca41bc4..64f9c866 100644
> --- a/common/report
> +++ b/common/report
> @@ -71,11 +71,16 @@ _xunit_make_testcase_report()
>  	local test_name="$2"
>  	local test_status="$3"
>  	local test_time="$4"
> +	local report_format="$5"
> +	local quiet
> +
> +	if [ "$report_format" = xunit-quiet ]; then
> +		quiet=yes
> +	fi
>  
>  	# TODO: other places may also win if no-section mode will be named like 'default/global'
>  	if [ $sect_name == '-no-sections-' ]; then
>  		sect_name='global'
> -
>  	fi
>  	local report=$tmp.report.xunit.$sect_name.xml
>  
> @@ -104,14 +109,16 @@ _xunit_make_testcase_report()
>  			_err_msg="Test $test_name failed, reason unknown"
>  		fi
>  		echo -e "\t\t<failure message=\"$_err_msg\" type=\"TestFail\" />" >> $report
> -		if [ -s "$full_file" ]; then
> +		if [ -z "$quiet" -a -s "$full_file" ]; then
>  			echo -e "\t\t<system-out>" >> $report
>  			printf	'<![CDATA[\n' >>$report
>  			cat "$full_file" | tr -dc '[:print:][:space:]' | encode_xml >>$report
>  			printf ']]>\n'	>>$report
>  			echo -e "\t\t</system-out>" >> $report
>  		fi
> -		if [ -f "$dmesg_file" ]; then
> +		if [ -n "$quiet" ]; then
> +		   :
> +		elif [ -f "$dmesg_file" ]; then
>  			echo -e "\t\t<system-err>" >> $report
>  			printf	'<![CDATA[\n' >>$report
>  			cat "$dmesg_file" | tr -dc '[:print:][:space:]' | encode_xml >>$report
> @@ -144,7 +151,7 @@ _make_section_report()
>  	local sect_time="$5"
>  	for report in $REPORT_LIST; do
>  		case "$report" in
> -		"xunit")
> +		"xunit"|"xunit-quiet")
>  			_xunit_make_section_report "$sect_name" "$tests_count" \
>  						   "$bad_count" "$notrun_count" \
>  						   "$sect_time"
> @@ -164,9 +171,9 @@ _make_testcase_report()
>  	local test_time="$4"
>  	for report in $REPORT_LIST; do
>  		case "$report" in
> -		"xunit")
> +		"xunit"|"xunit-quiet")
>  			_xunit_make_testcase_report "$sect_name" "$test_seq" \
> -						    "$test_status" "$test_time"
> +						    "$test_status" "$test_time" "$report"
>  			;;
>  		*)
>  			_dump_err "report format '$report' is not supported"
> @@ -178,7 +185,7 @@ _make_testcase_report()
>  _assert_report_list() {
>  	for report in $REPORT_LIST; do
>  		case "$report" in
> -		"xunit")
> +		"xunit"|"xunit-quiet")
>  			;;
>  		*)
>  			_fatal "report format '$report' is not supported"
> -- 
> 2.31.0
> 
