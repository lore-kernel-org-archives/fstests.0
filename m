Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4AFC4338F
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 23:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2367061028
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 23:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhHSX7d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Aug 2021 19:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbhHSX7d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Aug 2021 19:59:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5024DC061575;
        Thu, 19 Aug 2021 16:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ysAt0qOVkqX0b1YBP0DRQAcUuHGsRwUySI/CHhqjRbo=; b=vd9CEefNBQyCsStldq6Z6g2osU
        dHrLcAK8of6dQ6aa8VWDCFMuIj0IFZ/czQab0WoVeE9dby0kEcvOsAAViwiLHTj/58fZWSrjsIq6p
        4odimVrW71Y6eKzNfq+Md18lSM/DraMnP6frgztMO5XzfwmzHcswMyp+wh91AaHlLo7JVoXZAXCsf
        hPSaLshCNjIxrgw/EPMnBhXS6TzNVwBorfAFloqWiFN99yo0Sl2asKnXniDmdw9xzba+HLhyCedTl
        6oMp3SPxNCQ1Up+TB6fk53TnOx+eT+BNBw01Si47g9prY9yGynsNZNNkCkN2rUvzh+e39Z8WWg1Ue
        YvjA2ipw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGrvw-009mXO-C3; Thu, 19 Aug 2021 23:58:52 +0000
Date:   Thu, 19 Aug 2021 16:58:52 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org, hare@suse.de,
        dgilbert@interlog.com, jeyu@kernel.org, lucas.demarchi@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] common/module: add patient module rmmod support
Message-ID: <YR7wPBGu1Ba/4kzR@bombadil.infradead.org>
References: <20210811154512.1813622-1-mcgrof@kernel.org>
 <20210811154512.1813622-3-mcgrof@kernel.org>
 <YRkIttM75q3gLxpN@desktop>
 <YR0TEE8lUwo6QlHw@bombadil.infradead.org>
 <20210819022644.GP60846@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819022644.GP60846@e18g06458.et15sqa>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 19, 2021 at 10:26:44AM +0800, Eryu Guan wrote:
> On Wed, Aug 18, 2021 at 07:02:56AM -0700, Luis Chamberlain wrote:
> > On Sun, Aug 15, 2021 at 08:29:42PM +0800, Eryu Guan wrote:
> > > 
> > > Use "$max_tries -ne 0" to check inters seems better.
> > 
> > max_tries can be "forever", in which case this is -eq 0:
> > 
> > $ foo="forever"; if [[ $foo -eq 0 ]]; then echo buggy; else echo ok; fi
> > buggy
> 
> I see, that makes sense. Then perhaps some comments would help.

I had sent out a v3 before seeing this request. I'll send a v4 with 
a comment clarifying this.

  Luis
