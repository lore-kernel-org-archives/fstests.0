Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B040CC433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 22:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D01461A0A
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 22:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhCXW4S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 18:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhCXWzz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Mar 2021 18:55:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1EBC06174A
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 15:55:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 073FF1F45EE9
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     fstests@vger.kernel.org, kernel@collabora.com,
        "Lakshmipathi . G" <lakshmipathi.ganapathi@collabora.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 1/2] common: Escape SCRATCH_DEV variable
Organization: Collabora
References: <20210324224817.103503-1-andrealmeid@collabora.com>
Date:   Wed, 24 Mar 2021 18:55:46 -0400
In-Reply-To: <20210324224817.103503-1-andrealmeid@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Wed, 24 Mar 2021 19:48:16 -0300")
Message-ID: <87zgystb4d.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

André Almeida <andrealmeid@collabora.com> writes:

> Escape SCRATCH_DEV variable so it prints its name, instead of printing
> the value. If the value is "", the error message will not be very
> informative.
>
> Signed-off-by: André Almeida <andrealmeid@collabora.com>

cover letter is missing.  Other than that, for the entire series:

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com> 




-- 
Gabriel Krisman Bertazi
