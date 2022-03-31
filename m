Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA845C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 11:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiCaLVP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiCaLVO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 07:21:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D75417E364
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 04:19:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DEE5E21A98;
        Thu, 31 Mar 2022 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648725565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aNiYSdm01oLWX9YUgN8ae6eVBSu9pcp/xfB9hTPquEA=;
        b=t9+n7Z0JEmjC/8Ju2Dmiu9JNkYRba6F3Sjqsl3G7gWxEwVBXoAWULRuvSUb60rH9zBcwDd
        9cZzYIffSA/jo7ZRL5LKZhduKCH3nzHj1za0mtAepftypieG5jYpRcrTnOWqANmla4sbtH
        EDdeWGpwtn+Fc3tKe2ARM3atZrTb2iY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648725565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aNiYSdm01oLWX9YUgN8ae6eVBSu9pcp/xfB9hTPquEA=;
        b=O5FCNSUJmE6iPQLIOCmSaYlH3UDgJLaULnI5ph2/hCkn7DU5OCP1p7y8swm7I9auzK8Zc0
        fC5616ShUvzLbqBg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D1D37A3B8A;
        Thu, 31 Mar 2022 11:19:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 84113A0610; Thu, 31 Mar 2022 13:19:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] Fix generic/633 failure on systems without CONFIG_USER_NS
Date:   Thu, 31 Mar 2022 13:19:18 +0200
Message-Id: <20220331111920.8377-1-jack@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello!

these two patches fix a failure of test generic/633 on a system without
CONFIG_USER_NS.

								Honza
