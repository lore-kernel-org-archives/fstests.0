Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BE7C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Jan 2022 09:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiAJJKt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Jan 2022 04:10:49 -0500
Received: from verein.lst.de ([213.95.11.211]:37708 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242464AbiAJJKr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 10 Jan 2022 04:10:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1D32168AA6; Mon, 10 Jan 2022 10:10:44 +0100 (CET)
Date:   Mon, 10 Jan 2022 10:10:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 1/3] idmapped-mounts: remove redundant fchownat() call
 in setgid tests
Message-ID: <20220110091043.GA7680@lst.de>
References: <20220107145818.336126-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107145818.336126-1-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
