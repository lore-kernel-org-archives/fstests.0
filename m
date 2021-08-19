Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B4EC432BE
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 02:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E0F610FA
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Aug 2021 02:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhHSC1W (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Aug 2021 22:27:22 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:33261 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235384AbhHSC1W (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Aug 2021 22:27:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Ujw66VG_1629340004;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0Ujw66VG_1629340004)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Aug 2021 10:26:44 +0800
Date:   Thu, 19 Aug 2021 10:26:44 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org, hare@suse.de,
        dgilbert@interlog.com, jeyu@kernel.org, lucas.demarchi@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] common/module: add patient module rmmod support
Message-ID: <20210819022644.GP60846@e18g06458.et15sqa>
References: <20210811154512.1813622-1-mcgrof@kernel.org>
 <20210811154512.1813622-3-mcgrof@kernel.org>
 <YRkIttM75q3gLxpN@desktop>
 <YR0TEE8lUwo6QlHw@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR0TEE8lUwo6QlHw@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 18, 2021 at 07:02:56AM -0700, Luis Chamberlain wrote:
> On Sun, Aug 15, 2021 at 08:29:42PM +0800, Eryu Guan wrote:
> > On Wed, Aug 11, 2021 at 08:45:11AM -0700, Luis Chamberlain wrote:
> > >  common/config |  31 +++++++++++++++
> > >  common/module | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > 
> > Please also update README to document the new configurable variables.
> 
> Got it.
> 
> > >  2 files changed, 138 insertions(+)
> > > 
> > > diff --git a/common/config b/common/config
> > > index 005fd50a..9b8a2bc4 100644
> > > --- a/common/config
> > > +++ b/common/config
> > 
> > 100s as default seems a bit long to me, use 10s as in v1 patch?
> 
> In practice I tried using 10s and from my observations we *still* ran
> into false positives. So from my own testing peace of mind I'd prefer at
> least something higher, and if its going to be higher might as well go
> with something which at least makes painfully safe. I'll go with 50s
> for my next submission.
> 
> > > +	fi
> > > +else
> > > +	MODPROBE_RM_PATIENT_TIMEOUT_ARGS=""
> > > +	if [[ ! -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
> > > +		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_MS" != "forever" ]]; then
> > 
> > Should check MODPROBE_PATIENT_RM_TIMEOUT_SECONDS instead?
> 
> Indeed will fix.
> 
> > > diff --git a/common/module b/common/module
> > > index 39e4e793..03953fa1 100644
> > > --- a/common/module
> > > +++ b/common/module
> > > @@ -4,6 +4,8 @@
> > >  #
> > >  # Routines for messing around with loadable kernel modules
> > >  
> > > +source common/config
> > > +
> > 
> > Seems there's no need to source common/config here, as it's sourced in
> > common/rc, which is sourced by every test.
> 
> OK.
> 
> > > +	local max_tries_max=$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
> <-- snip -->
> 
> > > +	local max_tries=0
> <-- snip -->
> 
> > > +	max_tries=$max_tries_max
> > > +
> > > +	while [[ "$max_tries" != "0" ]]; do
> > 
> > Use "$max_tries -ne 0" to check inters seems better.
> 
> max_tries can be "forever", in which case this is -eq 0:
> 
> $ foo="forever"; if [[ $foo -eq 0 ]]; then echo buggy; else echo ok; fi
> buggy

I see, that makes sense. Then perhaps some comments would help.

Thanks,
Eryu

> 
> > > +			refcnt_is_zero=1
> > > +			break
> > > +		fi
> > > +		sleep 1
> > > +		if [[ "$max_tries" == "forever" ]]; then
> > > +			continue
> > > +		fi
> > > +		let max_tries=$max_tries-1
> > > +	done
> > > +
> > > +	if [[ $refcnt_is_zero -ne 1 ]]; then
> > > +		echo "custom patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max"
> > > +		return -1
> > > +	fi
> > > +
> > > +	# If we ran out of time but our refcnt check confirms we had
> > > +	# a refcnt of 0, just try to remove the module once.
> > > +	if [[ "$max_tries" == "0" ]]; then
> > 
> > $max_tries -eq 0
> 
> Same issue.
> 
>   Luis
