Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B342DC4338F
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Aug 2021 14:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9967261051
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Aug 2021 14:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhHRODd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhHRODc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Aug 2021 10:03:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2132AC061764;
        Wed, 18 Aug 2021 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5T2T8ugjMyi9ROUTbkrrKKiIT/5w9z7NpTWBJd1+ZR4=; b=YIctBOdYHy8zvOrMPIex53C85o
        uWDxKrKhH4ghn6j/CBgIJEr3adVzg8OmXIiVpj+/Bho5SfPD2+mvzSScmpjZwiJjloKJttgfnDi1N
        UNhdqqB+0pohfyvaHUMdHjKIZB0QA7ZLVZMO8RYLXUVHpIBI4KVV4TDbUrmzlwWQrHZCd7CfZ/0Zx
        ASQC3e/iD/HHpN62ItNiY8s3NTWHdEL0Y3eaAWTVDED32wTlADRghkbCHcDDrf97yij5pxiDsY7q2
        q6veYQmPUvl1OcJW+tHUo5jgmdvnDaISEZliPjZ7MT927UIi3sJqciuZ6dbJzs5jt4UsFg2lzapbs
        snWPuHIQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGM9g-005nva-58; Wed, 18 Aug 2021 14:02:56 +0000
Date:   Wed, 18 Aug 2021 07:02:56 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, hare@suse.de, dgilbert@interlog.com,
        jeyu@kernel.org, lucas.demarchi@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] common/module: add patient module rmmod support
Message-ID: <YR0TEE8lUwo6QlHw@bombadil.infradead.org>
References: <20210811154512.1813622-1-mcgrof@kernel.org>
 <20210811154512.1813622-3-mcgrof@kernel.org>
 <YRkIttM75q3gLxpN@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRkIttM75q3gLxpN@desktop>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Aug 15, 2021 at 08:29:42PM +0800, Eryu Guan wrote:
> On Wed, Aug 11, 2021 at 08:45:11AM -0700, Luis Chamberlain wrote:
> >  common/config |  31 +++++++++++++++
> >  common/module | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Please also update README to document the new configurable variables.

Got it.

> >  2 files changed, 138 insertions(+)
> > 
> > diff --git a/common/config b/common/config
> > index 005fd50a..9b8a2bc4 100644
> > --- a/common/config
> > +++ b/common/config
> 
> 100s as default seems a bit long to me, use 10s as in v1 patch?

In practice I tried using 10s and from my observations we *still* ran
into false positives. So from my own testing peace of mind I'd prefer at
least something higher, and if its going to be higher might as well go
with something which at least makes painfully safe. I'll go with 50s
for my next submission.

> > +	fi
> > +else
> > +	MODPROBE_RM_PATIENT_TIMEOUT_ARGS=""
> > +	if [[ ! -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
> > +		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_MS" != "forever" ]]; then
> 
> Should check MODPROBE_PATIENT_RM_TIMEOUT_SECONDS instead?

Indeed will fix.

> > diff --git a/common/module b/common/module
> > index 39e4e793..03953fa1 100644
> > --- a/common/module
> > +++ b/common/module
> > @@ -4,6 +4,8 @@
> >  #
> >  # Routines for messing around with loadable kernel modules
> >  
> > +source common/config
> > +
> 
> Seems there's no need to source common/config here, as it's sourced in
> common/rc, which is sourced by every test.

OK.

> > +	local max_tries_max=$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
<-- snip -->

> > +	local max_tries=0
<-- snip -->

> > +	max_tries=$max_tries_max
> > +
> > +	while [[ "$max_tries" != "0" ]]; do
> 
> Use "$max_tries -ne 0" to check inters seems better.

max_tries can be "forever", in which case this is -eq 0:

$ foo="forever"; if [[ $foo -eq 0 ]]; then echo buggy; else echo ok; fi
buggy

> > +			refcnt_is_zero=1
> > +			break
> > +		fi
> > +		sleep 1
> > +		if [[ "$max_tries" == "forever" ]]; then
> > +			continue
> > +		fi
> > +		let max_tries=$max_tries-1
> > +	done
> > +
> > +	if [[ $refcnt_is_zero -ne 1 ]]; then
> > +		echo "custom patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max"
> > +		return -1
> > +	fi
> > +
> > +	# If we ran out of time but our refcnt check confirms we had
> > +	# a refcnt of 0, just try to remove the module once.
> > +	if [[ "$max_tries" == "0" ]]; then
> 
> $max_tries -eq 0

Same issue.

  Luis
