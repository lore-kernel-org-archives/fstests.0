Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7C8C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Jul 2022 18:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiGGSJm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGGSJk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Jul 2022 14:09:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E2D1EAF8
        for <fstests@vger.kernel.org>; Thu,  7 Jul 2022 11:09:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1360622047;
        Thu,  7 Jul 2022 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657217378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdcWLw4+SPSV7IX49dG8ixwMrE+x6uVyFXrSdFbFKFs=;
        b=LJBwj3lMHjb3P/Jcaxks14u6D1LyrkEa8YKrmjrAsMF6B1pQCFCFJxzi14DacfmGjbASC0
        wfJs3ah0iO2ELmSPcL9rV2xuDkLQ6/oyIiJjXAEiiY8yX8uPU2pYeOtqW8KSIO+MRP0Clk
        glLxxLuN7KLZnofMAF0Vtd5F/qmAAHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657217378;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdcWLw4+SPSV7IX49dG8ixwMrE+x6uVyFXrSdFbFKFs=;
        b=PKUlcOPHzwRW6NiyjW7aqas2/290paRy8JvtW8lTsaBSxC3ObhdvGMajKOnO5dCu3m1NEg
        acDx/AiiuvvT0PAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8E8713A33;
        Thu,  7 Jul 2022 18:09:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6phnN2Ehx2JUDAAAMHmgww
        (envelope-from <ddiss@suse.de>); Thu, 07 Jul 2022 18:09:37 +0000
Date:   Thu, 7 Jul 2022 20:09:36 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v3 5/5] check: add -L <n> parameter to rerun failed
 tests
Message-ID: <20220707200936.66d1b30d@suse.de>
In-Reply-To: <20220706235452.694341f0@suse.de>
References: <20220706112312.4349-1-ddiss@suse.de>
        <20220706112312.4349-6-ddiss@suse.de>
        <YsXbt85xBNJIOwZu@magnolia>
        <20220706235452.694341f0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, 6 Jul 2022 23:54:52 +0200, David Disseldorp wrote:

> Thanks for the follow-up feedback, Darrick...
> 
> On Wed, 6 Jul 2022 12:00:07 -0700, Darrick J. Wong wrote:
...
> > >  
> > > +# retain files which would be overwritten in subsequent reruns of the same test
> > > +_stash_fail_loop_files() {
> > > +	local test_seq="$1"
> > > +	local suffix="$2"
> > > +
> > > +	for i in "${REPORT_DIR}/${test_seq}.full" \
> > > +		 "${REPORT_DIR}/${test_seq}.dmesg" \
> > > +		 "${REPORT_DIR}/${test_seq}.out.bad"; do
> > > +		[ -f "$i" ] && cp "$i" "${i}${suffix}"    
> > 
> > I wonder, is there any particular reason to copy the output file and let
> > it get overwritten instead of simply mv'ing it?  
> 
> The copy is left over from an earlier version I had where xunit report
> generation was done after the copy. Looking closer:
> - .full is removed in _begin_fstest()
> - _check_dmesg() overwrites .dmesg and retains on failure or KEEP_DMESG
> - out.bad is removed in the main check loop prior to seq invocation
> - .notrun, .core and .hints are also removed in the check loop at
>   various places before seq (.hints again in _begin_fstest())
> 
> One concern I have in changing this to a move is that external scripts
> may check for presence / parse these files after check invocation. I'd
> considered moving and then copying / symlinking back the .rerun0 files
> on rerun-on-failure loop completion but that's also pretty ugly. IMO
> leaving this as a copy, with the non-suffix file state left to reflect
> the results of the last rerun-on-failure loop, would make the most
> sense for now.

As a follow up here, I plan on squashing in the following change to
cover the extra notrun, core and hints files, and also avoid stale
.rerun# state:

--- a/check
+++ b/check
@@ -560,13 +560,14 @@ _expunge_test()
 
 # retain files which would be overwritten in subsequent reruns of the same test
 _stash_fail_loop_files() {
-       local test_seq="$1"
-       local suffix="$2"
+       local seq_prefix="${REPORT_DIR}/${1}"
+       local cp_suffix="$2"
 
-       for i in "${REPORT_DIR}/${test_seq}.full" \
-                "${REPORT_DIR}/${test_seq}.dmesg" \
-                "${REPORT_DIR}/${test_seq}.out.bad"; do
-               [ -f "$i" ] && cp "$i" "${i}${suffix}"
+       for i in ".full" ".dmesg" ".out.bad" ".notrun" ".core" ".hints"; do
+               rm -f "${seq_prefix}${i}${cp_suffix}"
+               if [ -f "${seq_prefix}${i}" ]; then
+                       cp "${seq_prefix}${i}" "${seq_prefix}${i}${cp_suffix}"
+               fi
        done
 }

Cheers, David
