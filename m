Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356B8C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Jan 2022 09:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbiAJJLn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Jan 2022 04:11:43 -0500
Received: from verein.lst.de ([213.95.11.211]:37720 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242623AbiAJJLW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 10 Jan 2022 04:11:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F388668AFE; Mon, 10 Jan 2022 10:11:19 +0100 (CET)
Date:   Mon, 10 Jan 2022 10:11:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 3/3] idmapped-mounts: add missing ownership comparisons
 to setgid tests
Message-ID: <20220110091119.GC7680@lst.de>
References: <20220107145818.336126-1-brauner@kernel.org> <20220107145818.336126-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107145818.336126-3-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
