Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B05C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Apr 2022 15:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378297AbiD2PXe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Apr 2022 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378349AbiD2PXc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Apr 2022 11:23:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8828382
        for <fstests@vger.kernel.org>; Fri, 29 Apr 2022 08:20:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A155668C4E; Fri, 29 Apr 2022 17:20:02 +0200 (CEST)
Date:   Fri, 29 Apr 2022 17:20:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 00/11] rename & split tests
Message-ID: <20220429152002.GA13661@lst.de>
References: <20220428151559.947144-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428151559.947144-1-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From a rather highlevel glance over the patches this looks good to me:

Acked: Christoph Hellwig <hch@lst.de>
