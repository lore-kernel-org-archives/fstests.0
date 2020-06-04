Return-Path: <SRS0=+7JN=7R=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32510C433DF
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 09:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E25020738
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 09:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VG24bIFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgFDJY4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:24:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39074 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726444AbgFDJY4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Jun 2020 05:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591262695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1RtKldUgPdjviZAG9TgWPtOTlS9qQ5sf9l0t48Kvbak=;
        b=VG24bIFCNUE/uyYCPGgAZlSpUOIHPfdOEBCNji+JN1w6kh76dDsHbsmhGKQy8b3OTKNiW+
        yUxL4kSZPIxDKeiobc3+nEf311hIvZ7p7e9WBj2C/DIoKooY/Q7FF3peZd5AR7x6JuVlqK
        qxeaIbVsgeuxigeevz2anGXqS9Ez2rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-X6fwcOIsM6mLnsijii33Xg-1; Thu, 04 Jun 2020 05:24:51 -0400
X-MC-Unique: X6fwcOIsM6mLnsijii33Xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BE99464;
        Thu,  4 Jun 2020 09:24:50 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2EF47CCC7;
        Thu,  4 Jun 2020 09:24:46 +0000 (UTC)
Date:   Thu, 4 Jun 2020 17:36:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Yong Sun <sunyong0511@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org,
        Yong Sun <yosun@suse.com>, Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: modify user name beginning with non-digit
Message-ID: <20200604093628.GJ1938@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>,
        Yong Sun <sunyong0511@gmail.com>, Eric Sandeen <sandeen@redhat.com>,
        fstests@vger.kernel.org, Yong Sun <yosun@suse.com>,
        Eryu Guan <guaneryu@gmail.com>
References: <20200603102035.552-1-yosun@suse.com>
 <20200604083023.GA26629@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604083023.GA26629@dell5510>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 04, 2020 at 10:30:23AM +0200, Petr Vorel wrote:
> Hi Sero,
> 
> > openSUSE and SLE don't support username begin with digit, so it will
> > skip test generic/597 and generic/598 by lack of 123456-fsgqa user.
> > generic/597 and 598 are not test username begin with digit on purpose
> > (different with generic/381). It's will be helpful to use an username
> > begin with non-digit in this case.
> 
> > Signed-off-by: Sun Yong <yosun@suse.com>
> > ---
> >  README            | 1 +
> >  tests/generic/597 | 4 ++--
> >  tests/generic/598 | 4 ++--
> >  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> > diff --git a/README b/README
> > index 094a7742..cffa0bc6 100644
> > --- a/README
> > +++ b/README
> > @@ -22,6 +22,7 @@ _______________________
> >  - create fsgqa test user ("sudo useradd -m fsgqa")
> >  - create fsgqa group ("sudo groupadd fsgqa")
> >  - create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
> I thought fsgqa-123456 is replacement for 123456-fsgqa. Thus I'd delete this
> line.
> > +- create fsgqa-123456 test user ("sudo useradd fsgqa-123456")
> 
> Also test tests/generic/381 still uses 123456-fsgqa. Shouldn't be replaced as
> well?

I don't know why this case need user '123456-fsgqa', but the generic/381 need
the 123456-fsgqa necessarily. It cover a bug about how xfs_quota deal with
user name begin with digits.

Thanks,
Zorro

> 
> >  ______________________
> >  USING THE FSQA SUITE
> > diff --git a/tests/generic/597 b/tests/generic/597
> > index 1d87a23a..c4d524b7 100755
> > --- a/tests/generic/597
> > +++ b/tests/generic/597
> > @@ -43,11 +43,11 @@ _require_sysctl_variable fs.protected_symlinks
> >  _require_sysctl_variable fs.protected_hardlinks
> >  # su in _require_user prints warnings about user name starts with a digit,
> >  # discard the warning
> > -_require_user 123456-fsgqa >/dev/null 2>&1
> > +_require_user fsgqa-123456 >/dev/null 2>&1
> I that redirection to /dev/null was due errors caused by starting with
> digits. As other _require_user calls don't have it, I'd remove the
> redirection. + remove that comment "su in _require_user prints warnings about
> user name starts with a digit," ... which is now useless/invalid.
> 
> Eric, was there a reson to use user name which starts with digit?
> 
> >  # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
> >  _require_user fsgqa
> 
> > -OWNER=123456-fsgqa
> > +OWNER=fsgqa-123456
> >  OTHER=fsgqa
> 
> >  # Save current system state to reset when done
> > diff --git a/tests/generic/598 b/tests/generic/598
> > index 998b62cf..1cf9a3d1 100755
> > --- a/tests/generic/598
> > +++ b/tests/generic/598
> > @@ -43,11 +43,11 @@ _require_sysctl_variable fs.protected_regular
> >  _require_sysctl_variable fs.protected_fifos
> >  # su in _require_user prints warnings about user name starts with a digit,
> >  # discard the warning
> > -_require_user 123456-fsgqa >/dev/null 2>&1
> > +_require_user fsgqa-123456 >/dev/null 2>&1
> >  # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
> >  _require_user fsgqa
> 
> > -USER1=123456-fsgqa
> > +USER1=fsgqa-123456
> >  USER2=fsgqa
> 
> >  # Save current system state to reset when done
> 
> Kind regards,
> Petr
> 

