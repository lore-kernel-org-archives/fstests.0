Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3344BEB64D7
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jun 2023 09:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjFUJZv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Jun 2023 05:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjFUJZJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Jun 2023 05:25:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94271213A
        for <fstests@vger.kernel.org>; Wed, 21 Jun 2023 02:24:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3650D1FD5E;
        Wed, 21 Jun 2023 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687339482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFcLPNYIMFY9iwnbag1WrWKmH8Z+TzuWgODaxuKZOww=;
        b=UwT+lfNppcVfCwK1Hwx8Z3GA5TwjOiXvsL5lUkh8O3ad9higk2vuhUxq2fQiHwFEnxBIJj
        SACwCsfKOsFUYjsMqRthMJjElpP1+bYNjm2ga32FHXdVQSbURvkyBGxrBZUj5TFoES9NnO
        wdUfRg7KzWj0Iy3rlqvgmZD+ihqpHlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687339482;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFcLPNYIMFY9iwnbag1WrWKmH8Z+TzuWgODaxuKZOww=;
        b=bhCLihEbIVtGNUA6sKHjXV4SZDo4fosEhSAk5P/t3hTlVa/7tnj5Lj3Pq62WULPDZTDuSg
        Pggv1iCmfzlFlkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01C33134B1;
        Wed, 21 Jun 2023 09:24:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /laIOtnBkmSbbgAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 21 Jun 2023 09:24:41 +0000
Date:   Wed, 21 Jun 2023 11:26:56 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Zorro Lang <zlang@redhat.com>, Amir Goldstein <amir73il@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: reduce runtime of check -n
Message-ID: <20230621112656.2efac042@echidna.fritz.box>
In-Reply-To: <20230621022355.yk7dy2e6sghcuzrp@zlang-mailbox>
References: <20230619105058.2711467-1-amir73il@gmail.com>
        <20230621022355.yk7dy2e6sghcuzrp@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Zorro and Amir,

On Wed, 21 Jun 2023 10:23:55 +0800, Zorro Lang wrote:

> On Mon, Jun 19, 2023 at 01:50:58PM +0300, Amir Goldstein wrote:
> > kvm-xfstests invokes check -n twice to pre-process and generate the
> > tests-to-run list, which is then being passed as a long list of tests
> > for invkoing check in the command line.
> > 
> > check invokes dirname, basename and sed several times per test just
> > for doing basic string prefix/suffix trimming.
> > Use bash string pattern matching instead which is much faster.
> > 
> > Note that the following pattern matching expression change:
> > < test_dir=${test_dir#$SRC_DIR/*}  
> > > t=${t#$SRC_DIR/}  
> > does not change the meaning of the expression, because the
> > shortest match of "$SRC_DIR/*" that is being trimmed is "$SRC_DIR/"
> > and removing the tests/ prefix is what this code intended to do.
> > 
> > With check -n, there is no need to cleanup the results dir,
> > but check -n is doing that for every single listed test.
> > Move the cleanup of results dir to before actually running the test.
> > 
> > These improvements to check pre-test code cut down several minutes
> > from the time until tests actually start to run with kvm-xfstests.
> > 
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> > 
> > Zorro,
> > 
> > Just to clarify, this change is not expected to change behavior -
> > only to improve runtime of check -n and the things that happen
> > before the first test is invoked.
> > 
> > Thanks,
> > Amir.
> > 
> >  check | 22 +++++++++-------------
> >  1 file changed, 9 insertions(+), 13 deletions(-)
> > 
> > diff --git a/check b/check
> > index e36978c1..1a16eccb 100755
> > --- a/check
> > +++ b/check
> > @@ -399,9 +399,9 @@ if $have_test_arg; then
> >  		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
> >  			list=$(cd $SRC_DIR; echo $1)
> >  			for t in $list; do
> > -				test_dir=`dirname $t`
> > -				test_dir=${test_dir#$SRC_DIR/*}
> > -				test_name=`basename $t`
> > +				t=${t#$SRC_DIR/}  
> 
> Actually I'm not sure what's this line for. We get $list by "cd $SRC_DIR; echo $1",
> is there any chance to have "$SRC_DIR" in $t (or $test_dir) ?

Indeed, this line can be dropped. One minor change in behaviour here is
that a test pattern with a wacky path prefix e.g. ../tests/xfs/00? will
no longer work. I think breaking such patterns is okay, but it could
also be resolved by more carefully extracting the last two path
components.

> > +				test_dir=${t%/*}
> > +				test_name=${t#*/}  
> 
> This change looks isn't related with the "check -n". Any reason to change
> that? Does the 'dirname' and 'basename' have poor performance, or some systems
> miss them?
> 
> I prefer the 'dirname' and 'basename' ways, if there's not a specific reason
> to change that. Due to they can deal with more complicated path name, e.g.
> "xfs//001". But the "$(cd $SRC_DIR; echo $1)" looks won't generate a path name
> likes that, so if you have a proper reason to make this change, that's fine.

The per-iteration `dirname` and `basename` subshells add multiple
seconds of latency to `./check -n *fs/*` in my test env.

Cheers, David
