Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70136C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 05:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiEPFyA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 01:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiEPFx6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 01:53:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3D2167D3
        for <fstests@vger.kernel.org>; Sun, 15 May 2022 22:53:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C643968B05; Mon, 16 May 2022 07:53:54 +0200 (CEST)
Date:   Mon, 16 May 2022 07:53:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 13/13] vfs/idmapped-mounts: remove invalid test
Message-ID: <20220516055354.GA12339@lst.de>
References: <20220512165250.450989-1-brauner@kernel.org> <20220512165250.450989-14-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512165250.450989-14-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
