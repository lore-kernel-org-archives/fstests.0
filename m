Return-Path: <SRS0=+7JN=7R=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978A1C433E0
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 13:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAB6206E6
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 13:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgFDNhV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:37:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:44870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbgFDNhV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Jun 2020 09:37:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 48EC0AC2C
        for <fstests@vger.kernel.org>; Thu,  4 Jun 2020 13:37:23 +0000 (UTC)
From:   aaptel@suse.com (=?utf-8?Q?Aur=C3=A9lien?= Aptel)
To:     fstests@vger.kernel.org
Subject: invalid user 123456-fsgqa
Date:   Thu, 04 Jun 2020 15:37:18 +0200
Message-ID: <87lfl3hrzl.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

Some tests require a second user named 123456-fsgqa
(generic/{381,383,597,598}) but that username is invalid on some Linux
systems (SUSE distros at least) where a username cannot start with a
digit.

Would it be ok to send a patch to change that second user to "fsgqa2"?

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
