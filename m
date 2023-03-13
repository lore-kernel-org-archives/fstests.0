Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD5BC74A4B
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 10:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCMKji (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCMKjh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 06:39:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7526625B81
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 03:39:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2115EB80FCD
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 10:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8042C433EF;
        Mon, 13 Mar 2023 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678703958;
        bh=Eh9GZc6EpMbPho3WagwqN9egFE9W97CiZ5sBFIEhdOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pWCgWCHcTdOvhPqAk3wQH5qACbZ/rIxfroYwX6nyQlzd8Fk9lMqYK6XAp8sBKRs9M
         W9MqhP4asb5icELaxL0ZMaEG4Qnk1vbqF0hif/IH4e97UkuV+GemDj7xfJTKenzAm2
         VEsQ79cv5ZerxxrhMtv4L32YKARprcORIg6MfgDP9tqghrAoAAVUW2RAPKp1rwFzRO
         puXZLujWPfarvwfU3TyAcDyuWioGr+QSRWAACHFUsE5o3XSRbeSxUXpNT+hCmRFOFz
         FIaQC8amSbYZMrxzOB3wzbxLsoMSsnLYntO410SqtXIapN8rP3alRMeZO8aE2Z1DpM
         QUBvvBKs70yLw==
Date:   Mon, 13 Mar 2023 11:39:14 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v2 3/9] vfs: Use tabs to indent, not spaces
Message-ID: <20230313103914.qlb7zh4n3cpjctmn@wittgenstein>
References: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
 <20230308111343.510970-4-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308111343.510970-4-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 08, 2023 at 12:13:37PM +0100, Rodrigo Campos wrote:
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
