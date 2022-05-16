Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60625C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 05:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbiEPFu3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 01:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiEPFu1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 01:50:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178713FA1
        for <fstests@vger.kernel.org>; Sun, 15 May 2022 22:50:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D12A68BEB; Mon, 16 May 2022 07:50:24 +0200 (CEST)
Date:   Mon, 16 May 2022 07:50:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 01/13] idmapped-mounts: make all tests set their
 required feature flags
Message-ID: <20220516055023.GC12299@lst.de>
References: <20220512165250.450989-1-brauner@kernel.org> <20220512165250.450989-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512165250.450989-2-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
