Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE28C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Jan 2022 09:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbiAJJLI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Jan 2022 04:11:08 -0500
Received: from verein.lst.de ([213.95.11.211]:37712 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242520AbiAJJLC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 10 Jan 2022 04:11:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E00768AFE; Mon, 10 Jan 2022 10:11:00 +0100 (CET)
Date:   Mon, 10 Jan 2022 10:10:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 2/3] idmapped-mounts: add more explanations to setgid
 tests
Message-ID: <20220110091059.GB7680@lst.de>
References: <20220107145818.336126-1-brauner@kernel.org> <20220107145818.336126-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107145818.336126-2-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
