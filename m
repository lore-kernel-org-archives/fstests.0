Return-Path: <SRS0=mI6p=55=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDDCC2BA19
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Apr 2020 14:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E412072C
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Apr 2020 14:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRxFrIEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgDMOlj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:41:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43654 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728557AbgDMOlj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Apr 2020 10:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586788897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dXcTsoXjkip/8cBwlPCKNHLAgp73U2oOR/Fj3ai8wsA=;
        b=MRxFrIEVFLT6262CcDU4r/49fyYwVYcKDFhHW7UpORtW+TLhF35kQpoYBYk33hCDHWrtY4
        nt0cM7eJyg3B1gcWszNsuhrpiWdmZK/VUhjZtCRR/riY9ecxDmyX8eNoWys1njVqvpNtTN
        WtThk28YFcmcBdQQhD2lCgt/gremz/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-k8vRbmS9O5uz5loKsyxqnw-1; Mon, 13 Apr 2020 10:41:35 -0400
X-MC-Unique: k8vRbmS9O5uz5loKsyxqnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E22C1005510;
        Mon, 13 Apr 2020 14:41:34 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 898495D9C9;
        Mon, 13 Apr 2020 14:41:33 +0000 (UTC)
Date:   Mon, 13 Apr 2020 22:53:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fstests: add _require_hardlinks for all necessary
 tests
Message-ID: <20200413145345.GZ14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Eric Sandeen <sandeen@sandeen.net>,
        fstests@vger.kernel.org
References: <83a816c2-fa40-c63f-7709-35863d412ded@redhat.com>
 <39716adc-c4db-65b3-b3c1-866bf3517d7f@redhat.com>
 <20200412070528.GX14282@dhcp-12-102.nay.redhat.com>
 <62208b4b-ef01-5f08-b09d-4cb77fc82c9a@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62208b4b-ef01-5f08-b09d-4cb77fc82c9a@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 13, 2020 at 08:33:29AM -0500, Eric Sandeen wrote:
> On 4/12/20 2:05 AM, Zorro Lang wrote:
> > On Thu, Apr 09, 2020 at 02:10:36PM -0500, Eric Sandeen wrote:
> >> Add a new _require function for hardlinks, to test hardlink support
> >> in all tests which need it.
> >>
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >> ---
> >>
> >> diff --git a/common/rc b/common/rc
> >> index 476d3d07..8bb9aa1f 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -3493,6 +3493,18 @@ _require_symlinks()
> >>  	rm -f $target $link
> >>  }
> >>  
> >> +_require_hardlinks()
> >> +{
> >> +	local target=`mktemp -p $TEST_DIR`
> >> +	local link=`mktemp -p $TEST_DIR -u`
> >> +	ln `basename $target` $link
> > 
> > I really doubt if it works. Why we need the basename of the $target? It cause we
> > create a link in *current* directory, and the current directory isn't the
> > $TEST_DIR.
> > 
> > The _require_symlinks won't fail due to symlink can be created cross filesystems,
> > but hardlink can't. But that's not the _require_symlinks want to test, right?
> > 
> > So why we need the basename? Please correct me if I'm wrong.
> 
> Sigh, no I'm wrong.  I just copied _require_symlinks without looking closely, and
> dropped the "-s" for a hardlink.
> 
> I forgot that the argument to ln -s can be an arbitrary relative path,
> 
> "Symbolic links can hold arbitrary text; if later resolved, a relative link is
> interpreted in relation to its parent directory."

Wow, yes! The manual of *ln* talk about that. I even never noticed that :-P
Thanks for telling me about it. So the _require_symlinks is fine, but the
_require_hardlinks need to fixed.

Thanks,
Zorro

> 
> $ mkdir /tmp/test
> $ export TEST_DIR=/tmp/test
> $ target=`mktemp -p $TEST_DIR`
> $ link=`mktemp -p $TEST_DIR -u`
> 
> $ echo $target
> /tmp/test/tmp.zjKtdM7Y0r
> $ echo $link
> /tmp/test/tmp.sdmFq6vyyl
> 
> $ ln -s `basename $target` $link
> 
> $ ls -l /tmp/test
> total 0
> lrwxrwxrwx. 1 sandeen sandeen 14 Apr 13 08:27 tmp.sdmFq6vyyl -> tmp.zjKtdM7Y0r
> -rw-------. 1 sandeen sandeen  0 Apr 13 08:27 tmp.zjKtdM7Y0r
> 
> Thanks for catching this, and sorry for making such a mess of this series.
> 
> -Eric
> 

