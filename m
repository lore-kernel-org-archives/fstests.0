Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D81DC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 11:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiCaLlG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiCaLlF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 07:41:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0946D9B
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 04:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78A4BB81BE2
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 11:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BC6C340ED;
        Thu, 31 Mar 2022 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648726756;
        bh=kfW9apqo9rj4Qcn4e1Z9z0BjZ9WsVRaLzyD4JtJNXJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MSeRv12Csxho7xOThAegP6dl/SCHjt9eYWUiRSaJ+CfNTxIW/hHm0luVaRvKn2pq7
         bRSUjQA0GClYp6ZZqtUcCGq6CVgrpi3TFuDbyaCXqypRXnT0p6fxUHyCoANyPZcNif
         xe0KDf8XFS3fMX573MNzBi//YiXV0RSEqFDz5oAGBJzBbjKJOiEH/dRuR3fWKa4o6C
         90l8om2tXJzsjSUYz1wxKoVkfNXKfLXYmDlaYueGYYoyjkgue6rcoExAzR2mAB4Vyd
         pYbPdgg3EC5tcLMtIk5eEBYxBKAQ2GVO7PlVuJGqxRcHb4rPHGdFyI8OV4j9QjFZtJ
         ym+ens+0ZSBdQ==
Date:   Thu, 31 Mar 2022 13:39:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix generic/633 failure on systems without
 CONFIG_USER_NS
Message-ID: <20220331113912.uzaojcp3ih5uibmr@wittgenstein>
References: <20220331111920.8377-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220331111920.8377-1-jack@suse.cz>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 31, 2022 at 01:19:18PM +0200, Jan Kara wrote:
> Hello!
> 
> these two patches fix a failure of test generic/633 on a system without
> CONFIG_USER_NS.

Thank you!
I've pulled and tested the patches.
RVB+TB on the individual patches.

Christian
