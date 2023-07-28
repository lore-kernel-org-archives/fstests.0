Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC946C001DE
	for <linux-fstests@archiver.kernel.org>; Fri, 28 Jul 2023 15:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbjG1PtV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjG1PtV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Jul 2023 11:49:21 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90726A0
        for <fstests@vger.kernel.org>; Fri, 28 Jul 2023 08:49:19 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-23.bstnma.fios.verizon.net [173.48.113.23])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36SFn7wU024452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 11:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690559349; bh=dK1M710zNGZ+RdOpkjFXQ/ecu2+hXHc4ExQvkHlFlCM=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=clWAPuKUrm2pkrEXX6oUeSjbgrXaPLsU9A4cH0+SeRAn2T4W35LQbMQoybyNjnxZ5
         HRPTh81BZpyBfLsfDp0BcO31Y5SBx5qcww7JE3tUIEYJg1a22oTbyQ+1h0++wddq4u
         P8XPp8N973w1QEUs1gWmP3ef4qPwakk9ekw98I/1g8Okgor2zO5wGWtyEXorY2YaD/
         B6fJg7uJdQAlTw6ZCOwVg0SOc+rwJix9M8uC2MHoUgKtDoKiWJQhW2Qrrx3Nhi8ISJ
         o82iJzuJiLPUrQvjrmSYAqB6jB53JBfTi7fo4dLPIO5SKgFi6mr06otHAo3Fp0dPKo
         e/ESOlkd4BPcQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BC3DE15C04EF; Fri, 28 Jul 2023 11:49:07 -0400 (EDT)
Date:   Fri, 28 Jul 2023 11:49:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: install soak_duration.awk
Message-ID: <20230728154907.GA606216@mit.edu>
References: <20230727190512.357064-1-tytso@mit.edu>
 <20230727191824.GF11377@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727191824.GF11377@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 27, 2023 at 12:18:24PM -0700, Darrick J. Wong wrote:
> > installed or the checks script will bomb out of SOAK_DURATION is set

One more typo fix:  s/of/if/

I think I've gotten way too spoiled by automatic spell/grammar
checking in GMail and Google Docs....

							- Ted
