Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0DDC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Apr 2022 13:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355412AbiDLNPD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 09:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356681AbiDLNOB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 09:14:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6F4639C
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 05:59:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD6C61F38D;
        Tue, 12 Apr 2022 12:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649768389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7S0qDUUaVZNG3xYtYwIQXNhb8Prr/IRh01Tb1o2gaRE=;
        b=MneXM9ubkPv10VW6SmIHyqNslMX5WwJ6CSeWO+3dweqRxCjN5SHG2srfqN9AXY8AjvAi36
        Yuul52u6fwSA08ZbuQGvrQV1wofC+AOmaVNVeAVirH5yRvAeoo16HRNYTEYJ/XN0HKJM1M
        vzuTyvRbLUiacbz2LOM7/BRcno2j1KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649768389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7S0qDUUaVZNG3xYtYwIQXNhb8Prr/IRh01Tb1o2gaRE=;
        b=MpsuaDyl6yXfAK/DbHP6Hd31sETsRrM6vqzulKuyqJGLUxez8Z8l33kmu9jahu+5bsmYVa
        7jcA1YQX7VdtF/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9537513780;
        Tue, 12 Apr 2022 12:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id plM/I8V3VWKhCQAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 12 Apr 2022 12:59:49 +0000
Date:   Tue, 12 Apr 2022 14:59:42 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
Message-ID: <20220412145942.0a268875@suse.de>
In-Reply-To: <20220411054833.2157779-1-david@fromorbit.com>
References: <20220411054833.2157779-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:

> From: Dave Chinner <dchinner@redhat.com>
> 
> If you ctrl-c generic/019, it leaves fsstress processes running.
> Kill them in the cleanup function so that they don't have to be
> manually killed after interrupting the test.
> 
> While touching the _cleanup() function, make it do everything that
> the generic _cleanup function it overrides does and fix the
> indenting.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/generic/019 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/019 b/tests/generic/019
> index db56dac1..cda107f4 100755
> --- a/tests/generic/019
> +++ b/tests/generic/019
> @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -    disallow_fail_make_request
> -    rm -f $tmp.*
> +	kill $fs_pid $fio_pid &> /dev/null
> +	disallow_fail_make_request
> +	cd /
> +	rm -r -f $tmp.*
>  }
>  
>  RUN_TIME=$((20+10*$TIME_FACTOR))

Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
wait, but should be fine as-is:
Reviewed-by: David Disseldorp <ddiss@suse.de>

Cheers, David
