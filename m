Return-Path: <SRS0=uX+y=7V=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7090C433DF
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Jun 2020 01:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BCA20774
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Jun 2020 01:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Crvevemn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgFHBzi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Jun 2020 21:55:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28125 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727972AbgFHBzi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Jun 2020 21:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591581336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mnumY/G37aFIBiNAFZ7Eu8MiRAI2TNPs9deoro+um4A=;
        b=Crvevemn0r2/Wszo/R4H2EzYW1lVW3q+6d8C/94Xc0efevjcv0rxpz9HhdRkBmOaMdtQMT
        cVsQpnPLmd287d3jpU4gqSKUm/3THTdLdxc4dkRvDP4ur7ZUgWXOe/7Qx/XQp+msFnyRpJ
        581/LfNwIuxSfTSp2RK3om/Rq5jiHPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-Uhwjfeb2NZii3HQn0QE8ag-1; Sun, 07 Jun 2020 21:55:34 -0400
X-MC-Unique: Uhwjfeb2NZii3HQn0QE8ag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 959EC1005510;
        Mon,  8 Jun 2020 01:55:32 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C265891E8;
        Mon,  8 Jun 2020 01:55:31 +0000 (UTC)
Date:   Mon, 8 Jun 2020 10:07:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: invalid user 123456-fsgqa
Message-ID: <20200608020720.GK1938@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>,
        fstests@vger.kernel.org
References: <87lfl3hrzl.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfl3hrzl.fsf@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 04, 2020 at 03:37:18PM +0200, Aurélien Aptel wrote:
> Hi,
> 
> Some tests require a second user named 123456-fsgqa
> (generic/{381,383,597,598}) but that username is invalid on some Linux
> systems (SUSE distros at least) where a username cannot start with a
> digit.
> 
> Would it be ok to send a patch to change that second user to "fsgqa2"?

No.

For g/381 and g/383, the 123456-fsgqa is necessary, they test xfs_quota with
user/group name beginning with digits, they're known bug coverage. If you system
can't create a user name likes 123456-fsgqa, just skip that. I think if your
system doesn't have 123456-fsgqa, the g/381 and g/383 will _notrun automatically,
right?

I don't learn about g/597,598(Eric might know that), if some other cases just
need another user name, you can have fsgqa2 or anyother names. But please update
README, if you change that.

Thanks,
Zorro

> 
> Cheers,
> -- 
> Aurélien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
> 

