Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4D8C43334
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Jul 2022 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiGKQKj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Jul 2022 12:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiGKQKh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Jul 2022 12:10:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73657A500
        for <fstests@vger.kernel.org>; Mon, 11 Jul 2022 09:10:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26BGAVNt009251
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 12:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657555833; bh=pR1QkdY4cG/PKKC8CwScSg7PyL2YJcLVLFllqDCrSkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YAB+aez2ezzQwmSNJ800EKqotgNWutmdEEKSI7umlNr0yGAkl8biJtAXR/zKZY0CB
         c4vZQvazgPFbhdE49oJvwvOBq69YEbXP+hPSwwTJWI01W3BHuX53ZUDoy2GQDqGOBH
         xYYXQW/amSzd/hWTkeU6gq8+XIX1g83OWEAPm82M4urwdaPzXeWbBxmSh3ardkFjWD
         rofMixbIuuC08LdSpfcpRK5kCEne09mozOAOmxMIucKQC2HicBhpUGadRvXT9tcnh+
         O0ZzTF4rK+s0G06Lv4ZwwB/46F8ZaFxbEK0Ekod3bcbdp/QBWGm6OHuI/W2yN78QvM
         01MaX66JU794Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CD52615C3418; Mon, 11 Jul 2022 12:10:31 -0400 (EDT)
Date:   Mon, 11 Jul 2022 12:10:31 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH -v2] report: add support for the xunit-quiet format
Message-ID: <YsxLd2f9CxDZH05I@mit.edu>
References: <20220711160436.2102299-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711160436.2102299-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 11, 2022 at 12:04:36PM -0400, Theodore Ts'o wrote:
> The xunit-quiet format exludes the NNN.{full,dmesg,bad} files in

Oops, sorry this should have beeb ***includes*** the
NNN.{full,dmesg,bad} files....

> <system-out> and <system-err> nodes.
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
