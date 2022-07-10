Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2D3C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Jul 2022 21:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiGJVma (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Jul 2022 17:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJVm3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Jul 2022 17:42:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF51146B
        for <fstests@vger.kernel.org>; Sun, 10 Jul 2022 14:42:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CEEC6225FA;
        Sun, 10 Jul 2022 21:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657489346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzqHo/kYnorys9xwXi+OtCyXzWxhu7oVOhq6bU5hRyc=;
        b=FyDBZH37mn3wG7IiM0F7OMJdUk0/ztL8EWPLkTqq/rDG6FNa/i3B0T+WgkWL0gtDClWYup
        hrtOKkz5JBlBZd/EbHTuFROLV/s1hoDhrPA+o/7o/RDlbMracZsgn8D7b1UVoKdJeAII/8
        RBlDffMOiyBPj01xdOsThCJIFxZzk4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657489346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzqHo/kYnorys9xwXi+OtCyXzWxhu7oVOhq6bU5hRyc=;
        b=tki2TFxKoWFLAjMlP+EYdjeDLJzdqQQRPWweNNKvR6Fk9N9Jnj8ZYkVq90rfnJJnIyRc4d
        pOs0XNxPId8wqGAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2147132FD;
        Sun, 10 Jul 2022 21:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UqQAKsJHy2LBXAAAMHmgww
        (envelope-from <ddiss@suse.de>); Sun, 10 Jul 2022 21:42:26 +0000
Date:   Sun, 10 Jul 2022 23:42:23 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] report: add support for the xunit-quiet format
Message-ID: <20220710234223.3cddaa96@suse.de>
In-Reply-To: <20220708223219.1872812-1-tytso@mit.edu>
References: <20220708223219.1872812-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri,  8 Jul 2022 18:32:19 -0400, Theodore Ts'o wrote:

> The xunit-quiet format exludes the NNN.{full,dmesg,bad} files in
> <system-out> and <system-err> nodes.
> 
> For test runners that save the enttire results directory to preserve
> all of the test artifacts, capturing the NNN.{full,dmesg,bad} in the
> results.xml file is redundant.  In addition, if the NNN.bad is too
> large, it can cause the junitparser python library to refuse to parse
> the XML file to prevent potential denial of service attacks[1].  A
> simple way to avoid this problem is to simply to have xfstests to omit
> the <system-out> and <system-err> nodes.
> 
> [1] https://gitlab.com/gitlab-org/gitlab/-/issues/268035
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: David Disseldorp <ddiss@suse.de>
Looks fine. A minor nit below...

> ---
> 
> Note: this patch depends on David Disseldorp's "add option to rerun
> failed tests"  series.
> 
>  check         |  2 +-
>  common/report | 20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/check b/check
> index 27ebb0c2..d4d436c0 100755
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
> index 5ca41bc4..cdf36b3e 100644
> --- a/common/report
> +++ b/common/report
> @@ -71,6 +71,12 @@ _xunit_make_testcase_report()
>  	local test_name="$2"
>  	local test_status="$3"
>  	local test_time="$4"
> +	local report_format="$5"
> +	local quiet
> +
> +	if [ "$report_format" = xunit-quiet ]; then
> +	    quiet=yes
        ^^^^
Nit: xfstests mostly uses tab based indentation. Same for ':' lower down
