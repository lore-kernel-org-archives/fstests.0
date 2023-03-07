Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F78FC6FD1A
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 16:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjCGQvv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCGQve (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 11:51:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D39B99678
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 08:47:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D55A614DE
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 16:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5464C433EF;
        Tue,  7 Mar 2023 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207638;
        bh=M0T4ByTU90oCGKHASTG1Xj/Ntwo6LVjvKVUL0GEOebA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TToo6mJnkL9jhcKkvRpp13FqK2ZGtRjZ1zUNbwGUcxfgOwYMyYZZWkmojvUro3LIq
         iFZ1QtEysNNCj3dnOuZV2fnaG0hdO/L+OBNq1IvvxAkZDZRkRH2JqyfSzZGghwtuN/
         9fQ5MjNKnve5oqfn0Lw6/8kCN4k6ElJauRxO5JEDWMO5bqfh8hNNiM2FOcFgqZa/JN
         wwCQxVAkl3aoXalYwPJ9DWC32nV2Syp6XmY4z8YrJNPV0DMU7k/tX6Cdk8PI0YOsfU
         gTW9t/d0hh0GOB/unEKJxyHWb1QcvgynpZ3gT/872IbN+FhGRAlW4CRSgsfum/d3md
         lMJYqXx+EMQ2w==
Date:   Tue, 7 Mar 2023 17:47:15 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH 04/11] vfs: Make switch_userns set PR_SET_DUMPABLE
Message-ID: <20230307164715.h7k4f55q3cs3qrrz@wittgenstein>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-5-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307114507.332309-5-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 07, 2023 at 12:45:00PM +0100, Rodrigo Campos wrote:
> We need PR_SET_DUMPABLE in order to write the mapping files when
> creating a userns. From prctl(2) PR_SET_DUMPABLE is reset when the
> process's effective user or group ID is changed.
> 
> As we are changing the EUID here, we also reset it to allow creating
> nested userns with subsequent switch_users() calls.
> 
> This was not causing any issues because we weren't using switch_users()
> to create nested userns. Nested userns were created with
> userns_fd_cb()/create_userns_hierarchy() that set PR_SET_DUMPABLE.
> 
> Future patches will rely on switch_users() to create nested userns. So
> this patch fixes that.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
