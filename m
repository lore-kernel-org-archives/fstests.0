Return-Path: <SRS0=wiEE=5S=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AD6C43331
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Apr 2020 12:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09459206F8
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Apr 2020 12:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgDBMWr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:22:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbgDBMWr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Apr 2020 08:22:47 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-Tne6Rb3CO-W9AacJxitonA-1; Thu, 02 Apr 2020 08:22:44 -0400
X-MC-Unique: Tne6Rb3CO-W9AacJxitonA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A03B800D5B;
        Thu,  2 Apr 2020 12:22:43 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-116-213.phx2.redhat.com [10.3.116.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12FEFB19B8;
        Thu,  2 Apr 2020 12:22:43 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 085671A02B5; Thu,  2 Apr 2020 08:22:42 -0400 (EDT)
Date:   Thu, 2 Apr 2020 08:22:42 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/571: skip test on filesystems that don't
 support F_SETLEASE fcntl
Message-ID: <20200402122242.GA5469@aion.usersys.redhat.com>
References: <20200401172659.299308-1-smayhew@redhat.com>
 <20200402103946.GA9028@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20200402103946.GA9028@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aion.usersys.redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Christoph,

On Thu, 02 Apr 2020, Christoph Hellwig wrote:

> On Wed, Apr 01, 2020 at 01:26:59PM -0400, Scott Mayhew wrote:
> > Add an option to the locktest program to check for fcntl setlease
> > support, and skip the generic/571 test on filesystems where the check
> > returns EINVAL.
> 
> The changes to locktest.c seem to contain some whitespace damange.
> 
The changes are consistent with the existing locktest.c, which uses a
mixture of tabs and spaces.

-Scott

> Otherwie this looks sensible to me.
> 

