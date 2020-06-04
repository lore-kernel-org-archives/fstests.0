Return-Path: <SRS0=+7JN=7R=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FCEC433DF
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 10:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F044207D5
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 10:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgFDKr7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:47:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:44908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFDKr6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Jun 2020 06:47:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30E0EAC53;
        Thu,  4 Jun 2020 10:48:01 +0000 (UTC)
Date:   Thu, 4 Jun 2020 12:47:55 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Yong Sun <sunyong0511@gmail.com>
Cc:     fstests@vger.kernel.org, Yong Sun <yosun@suse.com>,
        zlang@redhat.com
Subject: Re: [PATCH v2] fstests: modify user name beginning with non-digit
Message-ID: <20200604104755.GB26706@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200604095727.21720-1-yosun@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604095727.21720-1-yosun@suse.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Sero,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

