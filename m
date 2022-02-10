Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D025C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Feb 2022 13:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbiBJNME (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 10 Feb 2022 08:12:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiBJNMD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Feb 2022 08:12:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC70710A5
        for <fstests@vger.kernel.org>; Thu, 10 Feb 2022 05:12:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A42721121;
        Thu, 10 Feb 2022 13:12:03 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D879213B84;
        Thu, 10 Feb 2022 13:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WdslJyEPBWKaSQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Thu, 10 Feb 2022 13:12:01 +0000
Date:   Thu, 10 Feb 2022 05:04:47 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     raymond.barbiero.dev@gmail.com, fstests@vger.kernel.org,
        jack@suse.cz, mgorman@techsingularity.net
Subject: Re: [PATCH 0/4] dbench: few enhancements from mmtests
Message-ID: <20220210130447.x4wlfk72dzpbv2kb@offworld>
References: <20220209221849.434616-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220209221849.434616-1-mcgrof@kernel.org>
User-Agent: NeoMutt/20211029
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, 09 Feb 2022, Luis Chamberlain wrote:
>[0] https://github.com/gormanm/mmtests.git
>[1] https://github.com/mcgrof/dbench.git

Just so that I'm clear, you forked dbench from sahlberg's repo, right?
(git://git.samba.org/sahlberg/dbench.git) That's the one we've been
using for mmtests but I'm not sure if there is also older repos
around like from tridge.

Thanks,
Davidlohr
