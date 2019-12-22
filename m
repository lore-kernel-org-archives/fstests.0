Return-Path: <SRS0=f7WM=2M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C0CC2D0C8
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Dec 2019 21:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5B7206B7
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Dec 2019 21:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfLVVah (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Dec 2019 16:30:37 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35757 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726010AbfLVVah (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Dec 2019 16:30:37 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBMLUWE7032318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Dec 2019 16:30:33 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C531C420822; Sun, 22 Dec 2019 16:30:32 -0500 (EST)
Date:   Sun, 22 Dec 2019 16:30:32 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     sandeen@sandeen.net
Subject: Re: [PATCH] generic/386: check the correct field from df output
Message-ID: <20191222213032.GC108990@mit.edu>
References: <20191222212730.378358-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191222212730.378358-1-tytso@mit.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Dec 22, 2019 at 04:27:30PM -0500, Theodore Ts'o wrote:
> ...  However, looking at xfsprogs's quota command, I
> see no evidence that there is any line breaking logic.

Eric, since you're the xfsprogs maintainer --- am I missing something?
Was there a line breaking feature in the past?

    	    	 	  	     - Ted
