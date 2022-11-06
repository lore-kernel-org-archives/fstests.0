Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C7AC433FE
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Nov 2022 21:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiKFVog (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Nov 2022 16:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiKFVo0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Nov 2022 16:44:26 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DA2101F7
        for <fstests@vger.kernel.org>; Sun,  6 Nov 2022 13:44:25 -0800 (PST)
Received: from letrec.thunk.org (118.sub-174-205-35.myvzw.com [174.205.35.118])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2A6Li7cG026764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Nov 2022 16:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1667771051; bh=fmJ4tZasH2/tUMzQz/zsjqn1Dg/EyInsPncu+xZxJuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=STOb1qgDVP3dEx7wwIw3cb5ttkImWYPP+SNSHF5b29GKE/JJ9HI3gg2hqbRfU7M5N
         3y1xvzV5t8yf5Su7RAkaj6Q7GE57rbTBSWzz1wrrfn+7UXJPzQqrertqbYlUQNKnbH
         ZZYOlrdzZuB19dc8LibShJOy6Ov40hviJBWmxA7LFvN4yAJf33bOVkt+UGNrh8KZ4l
         ssqCxK6n7aTVayyPbM5RXqYHQXxLaT7D70NnbE7E860vWC3TPpqxt1kfVSFeHJVFe6
         fXTVxiLmetWeXb8D0g5JNRzTZ5PQwYt31fBAK8oexPLMGhu9NhTk1bWS8CDgAp/qAz
         BxkXw7Z/NaWdQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 4A29D8C01F6; Sun,  6 Nov 2022 16:44:05 -0500 (EST)
Date:   Sun, 6 Nov 2022 16:44:05 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <Y2gqpYhf5n8Y43eZ@mit.edu>
References: <20221105182918.24099-1-tytso@mit.edu>
 <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Nov 06, 2022 at 08:10:31PM +0800, Zorro Lang wrote:
> 
> Thanks Ted, actually I'm going to merge this patch (with g/457 fix by myself)
> this week.
> 
> But looks like you missed the change on g/457 (might forgot to commit). Anyway,
> I think it's not worth wasting one more week for this small change, I'll help
> to change g/457 when I merge this patch.

Argh, yeah, sorry, I forgot to do the "git add -u".  Anyway, here's
the leftover change that was in my git working directory, if it saves
you 5 seconds or so.  :-)

BTW, I noticed there were a number of fsx --replay-ops invocations
where we could potentially add the $FSX_AVOID.  OTOH, it would
probably make those tests completely pointless, so it might be easier
just for the test runners to relay on a group-based exclusion in those
cases.   What do you think?

				- Ted

diff --git a/tests/generic/457 b/tests/generic/457
index da75798f1..ca0f5e622 100755
--- a/tests/generic/457
+++ b/tests/generic/457
@@ -83,7 +83,7 @@ FSX_OPTS="-N $NUM_OPS -d -k -P $SANITY_DIR -i $LOGWRITES_DMDEV"
 for j in `seq 0 $((NUM_FILES-1))`; do
 	# clone the clone from prev iteration which may have already mutated
 	_cp_reflink $SCRATCH_MNT/testfile$((j-1)) $SCRATCH_MNT/testfile$j
-	run_check $here/ltp/fsx $FSX_OPTS -S 0 -j $j $SCRATCH_MNT/testfile$j &
+	run_check $here/ltp/fsx $FSX_OPTS $FSX_AVOID -S 0 -j $j $SCRATCH_MNT/testfile$j &
 done
 wait
 
